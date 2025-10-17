import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PsychologistPage extends StatefulWidget {
  const PsychologistPage({Key? key}) : super(key: key);

  @override
  State<PsychologistPage> createState() => _PsychologistPageState();
}

class _PsychologistPageState extends State<PsychologistPage> {
  String? selectedPsychologist;

  @override
  void initState() {
    super.initState();
    _fetchSelectedPsychologist(); // Busca o psicólogo associado ao paciente ao inicializar a página
  }

  // Função para buscar o psicólogo associado ao paciente
  Future<void> _fetchSelectedPsychologist() async {
    final userEmail = 'andreiafernandes@gmail.com'; // Substituir pelo email do utilizador autenticado

    try {
      final patientDoc = await FirebaseFirestore.instance
          .collection('Pacientes')
          .doc(userEmail)
          .get();

      setState(() {
        selectedPsychologist = patientDoc.data()?['selected_psychologist_id'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar psicólogo: $e')),
      );
    }
  }

  // Função para selecionar um novo psicólogo
  Future<void> _selectPsychologist(String psychologistId) async {
    final userEmail = 'andreiafernandes@gmail.com'; // Substituir pelo email do utilizador autenticado

    try {
      await FirebaseFirestore.instance
          .collection('Pacientes')
          .doc(userEmail)
          .update({
        'selected_psychologist_id': psychologistId,
      });

      await _fetchSelectedPsychologist(); // Atualiza a exibição do psicólogo selecionado

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Psicólogo atualizado para $psychologistId')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar psicólogo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(), // Fundo decorativo
          SafeArea(
            child: Column(
              children: [
                _buildHeader('Psychologist'),
                 SizedBox(height: 200),
                ElevatedButton(
                  onPressed: _showCurrentPsychologistDialog,
                  style: _largeButtonStyle(),
                  child: Text(
                    'See My Psychologist',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllPsychologistsPage(
                          onSelect: _selectPsychologist,
                        ),
                      ),
                    );
                  },
                  style: _largeButtonStyle(),
                  child: Text(
                    'See All Psychologists',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white.withOpacity(0.9),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  ButtonStyle _largeButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      minimumSize: Size(250, 70),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/img_1.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.6),
            BlendMode.lighten,
          ),
        ),
      ),
    );
  }

  void _showCurrentPsychologistDialog() {
    if (selectedPsychologist == null) {
      _showAlertDialog('Seu Psicólogo', 'Nenhum psicólogo atribuído.');
      return;
    }

    showDialog(
      context: context,
      builder: (context) => FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Médicos')
            .doc(selectedPsychologist)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AlertDialog(
              title: Text('Seu Psicólogo'),
              content: Center(child: CircularProgressIndicator()),
            );
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return _buildNoDetailsDialog();
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          return AlertDialog(
            title: Text('Seu Psicólogo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${data['name'] ?? snapshot.data!.id}'),
                Text('Especialidade: ${data['specialty'] ?? 'N/A'}'),
                Text('Idade: ${data['age'] ?? 'N/A'}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Fechar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllPsychologistsPage(
                        onSelect: _selectPsychologist,
                      ),
                    ),
                  );
                },
                child: Text('Trocar Psicólogo'),
              ),
            ],
          );
        },
      ),
    );
  }

  AlertDialog _buildNoDetailsDialog() {
    return AlertDialog(
      title: Text('Seu Psicólogo'),
      content: Text('Nenhum detalhe disponível.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fechar'),
        ),
      ],
    );
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }
}

class AllPsychologistsPage extends StatelessWidget {
  final Function(String) onSelect;

  AllPsychologistsPage({Key? key, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                _buildHeader('Todos os Psicólogos'),
                SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Médicos').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final psychologists = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: psychologists.length,
                        itemBuilder: (context, index) {
                          final doc = psychologists[index];
                          final data = doc.data() as Map<String, dynamic>;
                          final name = data['name'] ?? doc.id;
                          final age = data['age'] ?? 'N/A';
                          final specialty = data['specialty'] ?? 'N/A';

                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text(
                                name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Especialidade: $specialty'),
                                  Text('Idade: $age'),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () => _showConfirmationDialog(context, doc.id, name),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  minimumSize: Size(100, 40),
                                ),
                                child: Text('Selecionar'),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white.withOpacity(0.9),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String id, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Seleção'),
        content: Text('Tem a certeza que deseja selecionar $name como seu psicólogo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              onSelect(id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
