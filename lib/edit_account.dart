import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import para traduções

class EditAccountPage extends StatefulWidget {
  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  // Controladores para os campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Instâncias do Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = true; // Variável para exibir o carregamento enquanto os dados são carregados

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Carrega os dados do utilizador ao iniciar a página
  }

  // Função para carregar os dados do utilizador
  Future<void> _loadUserData() async {
    try {
      final User? user = _auth.currentUser; // Obtém o utilizador autenticado
      if (user != null) {
        final String userEmail = user.email!;
        final DocumentSnapshot userDoc = await _firestore
            .collection('Pacientes')
            .doc(userEmail)
            .get(); // Obtém os dados do utilizador no Firestore
        if (userDoc.exists) {
          setState(() {
            _nameController.text = userDoc['name'] ?? ''; // Preenche o nome
            _emailController.text = userDoc['email'] ?? ''; // Preenche o email
            _dobController.text = userDoc['date_of_birth'] ?? ''; // Preenche a data de nascimento
            _phoneController.text = userDoc['phone'] ?? ''; // Preenche o telefone
            _isLoading = false; // Remove o indicador de carregamento
          });
        }
      }
    } catch (e) {
      print('Error loading data: $e'); // Log de erro
    }
  }

  // Função para salvar os dados editados do utilizador
  Future<void> _saveUserData() async {
    try {
      final User? user = _auth.currentUser; // Obtém o utilizador autenticado
      if (user != null) {
        final String userEmail = user.email!;
        await _firestore.collection('Pacientes').doc(userEmail).set(
          {
            'name': _nameController.text,
            'email': _emailController.text,
            'date_of_birth': _dobController.text,
            'phone': _phoneController.text,
          },
          SetOptions(merge: true), // Mescla os dados com os existentes
        );
        // Exibe mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.data_saved)),
        );
      }
    } catch (e) {
      print('Erro ao salvar os dados: $e'); // Log de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.error_saving_data)), // Mensagem de erro
      );
    }
  }

  // Função para exibir o diálogo de confirmação ao salvar alterações
  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.save_changes), // Título do diálogo
          content: Text(AppLocalizations.of(context)!.sure_save_changes), // Conteúdo do diálogo
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text(AppLocalizations.of(context)!.no), // Botão "Não"
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                _saveUserData(); // Salva os dados
              },
              child: Text(AppLocalizations.of(context)!.yes), // Botão "Sim"
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_2.png'), // Caminho da imagem de fundo
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4), // Transparência da imagem
                  BlendMode.lighten, // Clareia a imagem
                ),
              ),
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator()) // Exibe indicador de carregamento
              : SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Cabeçalho
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Colors.white.withOpacity(0.8), // Fundo translúcido
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.edit_account, // Texto do cabeçalho
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Avatar do utilizador
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: AssetImage('assets/images/me.png'), // Imagem do avatar
                  ),
                  SizedBox(height: 20),
                  // Campos de texto
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Campo: Nome
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.name_label,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color(0xFF21364E),
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFF21364E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Campo: Email (somente leitura)
                        TextField(
                          controller: _emailController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.email_label,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color(0xFF21364E),
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFF21364E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Campo: Data de nascimento
                        TextField(
                          controller: _dobController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.dob_label,
                            hintText: 'DD/MM/YYYY',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color(0xFF21364E),
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFF21364E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () async {
                            // Mostra o calendário para selecionar data
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2025),
                            );
                            if (pickedDate != null) {
                              _dobController.text =
                              "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        // Campo: Telefone
                        TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.phone_label,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color(0xFF21364E),
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFF21364E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // Botão para salvar alterações
                  ElevatedButton(
                    onPressed: () => _showSaveDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      side: BorderSide(color: Color(0xFF21364E), width: 1.5),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.save_changes_button, // Texto do botão
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
