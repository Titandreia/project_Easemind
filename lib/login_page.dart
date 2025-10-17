import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Suporte para traduções

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para os campos de e-mail e senha
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Chave global para validar o formulário
  final _formKey = GlobalKey<FormState>();

  // Variáveis para estado de carregamento e mensagens de erro
  bool _isLoading = false;
  String _errorMessage = '';

  // Função para fazer login no Firebase
  Future<void> _logIn(String email, String pass) async {
    // Verifica se o formulário está válido
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true; // Ativa o indicador de carregamento
      _errorMessage = ''; // Limpa mensagens de erro anteriores
    });

    try {
      // Tentativa de autenticação no Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      // Navega para a página inicial após login bem-sucedido
      Navigator.pushReplacementNamed(context, '/home_page');
    } on FirebaseAuthException catch (e) {
      // Tratamento de erros de autenticação específicos
      setState(() {
        switch (e.code) {
          case 'user-not-found':
            _errorMessage = AppLocalizations.of(context)!.email_not_found;
            break;
          case 'wrong-password':
            _errorMessage = AppLocalizations.of(context)!.incorrect_password;
            break;
          case 'invalid-email':
            _errorMessage = AppLocalizations.of(context)!.invalid_email;
            break;
          default:
            _errorMessage = '${AppLocalizations.of(context)!.error}: ${e.message}';
        }
      });
    } catch (e) {
      // Tratamento de erros inesperados
      setState(() {
        _errorMessage = '${AppLocalizations.of(context)!.unexpected_error}: $e';
      });
    } finally {
      setState(() {
        _isLoading = false; // Desativa o indicador de carregamento
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // O conteúdo preenche toda a tela
        children: [
          // Imagem de fundo
          Positioned(
            top: -140,
            child: Transform.scale(
              scale: 1.40, // Ajuste de escala para cobrir a tela
              child: Image.asset(
                'assets/images/img.png', // Caminho da imagem de fundo
                fit: BoxFit.cover, // A imagem cobre toda a área definida
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          // Camada de cor translúcida sobre a imagem
          Container(
            color: Color(0xFF89C2BF).withOpacity(0.4),
          ),
          // Formulário de login centralizado
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0), // Padding ao redor do conteúdo
              child: Form(
                key: _formKey, // Associa o formulário à chave global
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    // Nome do aplicativo
                    Text(
                      'EaseMind',
                      style: TextStyle(
                        fontSize: 65,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF21364E),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Slogan do aplicativo
                    Text(
                      AppLocalizations.of(context)!.help_from_distance,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF21364E),
                      ),
                    ),
                    SizedBox(height: 50),
                    // Campo de texto para e-mail
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                        filled: true,
                        fillColor: Colors.white, // Fundo branco
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                        ),
                      ),
                      validator: (value) {
                        // Validação para e-mail vazio
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enter_email;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    // Campo de texto para senha
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true, // Oculta o texto da senha
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password,
                        filled: true,
                        fillColor: Colors.white, // Fundo branco
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                        ),
                      ),
                      validator: (value) {
                        // Validação para senha vazia
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enter_password;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5),
                    // Botão "Esqueceu a senha?"
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot_password'); // Navega para a página de recuperação
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forgot_password,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    // Botão de login com indicador de carregamento
                    _isLoading
                        ? CircularProgressIndicator() // Exibe o indicador enquanto carrega
                        : ElevatedButton(
                      onPressed: () {
                        _logIn(
                          _usernameController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.sign_in),
                    ),
                     SizedBox(height: 15),
                    // Botão para criar conta
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/create_account'); // Navega para a página de criação de conta
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal, // Cor do botão
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.create_account,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    // Exibe mensagem de erro, se houver
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          _errorMessage, // Mostra a mensagem de erro
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
