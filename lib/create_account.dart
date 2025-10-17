import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import para traduções

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicialização do Firebase necessária
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Account', // Título da aplicação
      theme: ThemeData(
        primarySwatch: Colors.blue, // Cor principal
      ),
      home: AccountPageView(), // Página inicial definida como `AccountPageView`
    );
  }
}

// Página que controla diferentes telas usando PageView
class AccountPageView extends StatefulWidget {
  @override
  _AccountPageViewState createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  final PageController _pageController = PageController(initialPage: 0); // Controlador para o `PageView`

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController, // Controlador do `PageView`
        children: [
          CreateAccountPage(), // Página de criação de conta
          PlaceholderPage(AppLocalizations.of(context)!.next_page), // Página de exemplo
          PlaceholderPage(AppLocalizations.of(context)!.previous_page), // Outra página de exemplo
        ],
      ),
    );
  }
}

// Página de exemplo com texto dinâmico
class PlaceholderPage extends StatelessWidget {
  final String title; // Título da página

  PlaceholderPage(this.title); // Construtor que recebe o título

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title, // Exibe o título da página
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Estilo do texto
      ),
    );
  }
}

// Página de criação de conta
class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  // Controladores para os campos de texto
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedDistrict; // Distrito selecionado
  String? _selectedCity; // Cidade selecionada

  // Mapa de distritos e cidades
  final Map<String, List<String>> _districtCityMap = {
    "Lisboa": ["Lisboa", "Sintra", "Cascais", "Oeiras", "Amadora", "Loures", "Odivelas"],
    "Porto": ["Porto", "Vila Nova de Gaia", "Matosinhos", "Maia", "Gondomar", "Póvoa de Varzim"],
  };

  // Função para criar a conta do utilizador no Firebase
  Future<void> _createAccount() async {
    try {
      // Criação de utilizador no Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), // Email do utilizador
        password: _passwordController.text.trim(), // Palavra-passe do utilizador
      );

      // Armazenar dados do utilizador no Firestore
      await FirebaseFirestore.instance.collection('Pacientes').doc(_emailController.text.trim()).set({
        'name': _nameController.text.trim(), // Nome completo
        'date_of_birth': _dobController.text.trim(), // Data de nascimento
        'phone': _phoneController.text.trim(), // Número de telefone
        'district': _selectedDistrict, // Distrito selecionado
        'city': _selectedCity, // Cidade selecionada
        'email': _emailController.text.trim(), // Email
      });

      // Mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.account_created_success)), // Texto traduzido dinamicamente
      );
    } on FirebaseAuthException catch (e) {
      // Mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.error}: ${e.message}')), // Texto traduzido dinamicamente
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagem de fundo com redimensionamento
          Positioned(
            top: -100,
            child: Transform.scale(
              scale: 1.5, // Redimensiona a imagem
              child: Image.asset(
                'assets/images/img_4.png', // Caminho da imagem de fundo
                fit: BoxFit.cover, // Ajuste para cobrir toda a área
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          // Cor de fundo translúcida
          Container(
            color: Color(0xFF89C2BF).withOpacity(0.45), // Fundo translúcido
          ),
          // Formulário de criação de conta
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white.withOpacity(0.9), // Fundo translúcido do formulário
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Campo de texto: Nome completo
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.full_name, // Tradução dinâmica
                        ),
                      ),
                      SizedBox(height: 10),
                      // Campo de texto: Data de nascimento
                      TextField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.date_of_birth, // Tradução dinâmica
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _dobController.text =
                              "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                            });
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      // Dropdown: Distrito
                      DropdownButtonFormField<String>(
                        value: _selectedDistrict,
                        items: _districtCityMap.keys.map((String district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: Text(district),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.district, // Tradução dinâmica
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedDistrict = value;
                            _selectedCity = null; // Limpa a cidade selecionada ao alterar o distrito
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      // Dropdown: Cidade
                      DropdownButtonFormField<String>(
                        value: _selectedCity,
                        items: (_selectedDistrict != null)
                            ? _districtCityMap[_selectedDistrict!]!.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList()
                            : [],
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.city, // Tradução dinâmica
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      // Campo de texto: Telefone
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.phone_number, // Tradução dinâmica
                        ),
                        keyboardType: TextInputType.phone, // Tipo de teclado para números
                      ),
                      SizedBox(height: 10),
                      // Campo de texto: Email
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email, // Tradução dinâmica
                        ),
                        keyboardType: TextInputType.emailAddress, // Tipo de teclado para emails
                      ),
                      SizedBox(height: 10),
                      // Campo de texto: Palavra-passe
                      TextField(
                        controller: _passwordController,
                        obscureText: true, // Esconde o texto digitado
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password, // Tradução dinâmica
                        ),
                      ),
                      SizedBox(height: 20),
                      // Botão para criar conta
                      ElevatedButton(
                        onPressed: _createAccount, // Chama a função para criar conta
                        child: Text(AppLocalizations.of(context)!.create_account_button), // Tradução dinâmica
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
