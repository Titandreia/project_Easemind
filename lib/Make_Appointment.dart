import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MakeAppointmentPage extends StatefulWidget {
  MakeAppointmentPage({Key? key}) : super(key: key);

  @override
  State<MakeAppointmentPage> createState() => _MakeAppointmentPageState();
}

class _MakeAppointmentPageState extends State<MakeAppointmentPage> {
  String? selectedDoctor; // Médico selecionado
  List<String> availableTimes = []; // Horários disponíveis
  String? selectedTime; // Horário selecionado
  DateTime? selectedDate; // Data selecionada
  bool isLoading = true; // Indicador de carregamento

  @override
  void initState() {
    super.initState();
    fetchDoctorAndTimes(); // Carregar dados iniciais
  }

  /// Função para buscar o médico associado ao paciente e os horários disponíveis
  Future<void> fetchDoctorAndTimes() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser; // Obtém o utilizador atual
      if (user == null) {
        throw AppLocalizations.of(context)!.no_user_logged_in; // Exibe erro se não houver utilizador autenticado
      }

      String email = user.email!;

      // Busca informações do paciente
      DocumentSnapshot patientDoc = await FirebaseFirestore.instance
          .collection('Pacientes')
          .doc(email)
          .get();

      if (!patientDoc.exists) {
        throw AppLocalizations.of(context)!.patient_not_found;
      }

      String? doctorId = patientDoc['selected_psychologist_id']; // ID do médico associado

      if (doctorId == null) {
        throw AppLocalizations.of(context)!.no_doctor_assigned;
      }

      setState(() {
        selectedDoctor = doctorId;
      });

      // Busca horários disponíveis do médico
      DocumentSnapshot doctorDoc = await FirebaseFirestore.instance
          .collection('Médicos')
          .doc(doctorId)
          .get();

      if (!doctorDoc.exists) {
        throw AppLocalizations.of(context)!.doctor_not_found;
      }

      List<dynamic> times = doctorDoc['available times'] ?? [];
      setState(() {
        availableTimes = List<String>.from(times); // Converte os horários em lista de strings
        isLoading = false; // Finaliza carregamento
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Exibe mensagem de erro em um SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
      );
    }
  }

  /// Função para marcar a consulta
  Future<void> bookAppointment() async {
    if (selectedTime == null || selectedDate == null) {
      // Valida se horário e data foram selecionados
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.select_date_time)),
      );
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser; // Verifica utilizador autenticado
      if (user == null) {
        throw AppLocalizations.of(context)!.no_user_logged_in;
      }

      String email = user.email!;

      // Atualiza informações no Firestore (marcar consulta para o paciente)
      await FirebaseFirestore.instance.collection('Pacientes').doc(email).update({
        'appointments': FieldValue.arrayUnion([
          {
            'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
            'time': selectedTime,
            'doctor': selectedDoctor,
          }
        ])
      });

      // Remove o horário reservado dos horários disponíveis do médico
      await FirebaseFirestore.instance.collection('Médicos').doc(selectedDoctor).update({
        'available times': FieldValue.arrayRemove([selectedTime])
      });

      // Mostra mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.appointment_booked)),
      );

      // Limpa os valores selecionados
      setState(() {
        availableTimes.remove(selectedTime);
        selectedTime = null;
        selectedDate = null;
      });
    } catch (e) {
      // Exibe mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
      );
    }
  }

  /// Função para selecionar a data usando um `DatePicker`
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), // Permite selecionar até 1 ano no futuro
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Atualiza a data selecionada
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com imagem
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_1.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7),
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Cabeçalho
                Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white.withOpacity(0.9),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.make_appointment,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                if (isLoading)
                  Center(child: CircularProgressIndicator()) // Indicador de carregamento
                else ...[
                  // Exibição do médico
                  Text(
                    '${AppLocalizations.of(context)!.doctor}: $selectedDoctor',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  // Botão para selecionar a data
                  ElevatedButton(
                    onPressed: () => selectDate(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      selectedDate == null
                          ? AppLocalizations.of(context)!.select_date
                          : '${AppLocalizations.of(context)!.selected_date}: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Dropdown para selecionar o horário
                  DropdownButton<String>(
                    value: selectedTime,
                    hint: Text(AppLocalizations.of(context)!.select_time,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    items: availableTimes.map((time) {
                      return DropdownMenuItem<String>(
                        value: time,
                        child: Text(time, style: TextStyle(fontSize: 18)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTime = value; // Atualiza o horário selecionado
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  // Botão para confirmar a consulta
                  ElevatedButton(
                    onPressed: bookAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.book_appointment,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
