import 'package:flutter/material.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  bool _isSendingEmail = false; // Flag para indicar se o e-mail está sendo enviado
  final TextEditingController _emailController =
  TextEditingController(); // Controlador para o campo de e-mail

  // Função para validar o domínio do e-mail
  bool _isEmailValid(String email) {
    // Lista de domínios válidos
    List<String> validDomains = [
      'gmail.com',
      'hotmail.com',
      'yahoo.com',
      'icloud.com',
      'outlook.com',
      'isec.pt',
    ];

    // Verifica se o e-mail termina com um dos domínios válidos
    for (String domain in validDomains) {
      if (email.endsWith('@$domain')) {
        return true;
      }
    }
    return false;
  }

  // Função para simular envio de e-mail
  void _sendEmail() async {
    String email = _emailController.text;

    // Verifica se o campo de e-mail está vazio
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid e-mail address!'), // Mensagem de erro
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Verifica se o domínio do e-mail é válido
    if (!_isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Invalid e-mail! The domain must be one of the following: gmail.com, hotmail.com, isec.pt.'), // Mensagem de erro
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Inicia o envio de e-mail
    setState(() {
      _isSendingEmail = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Simula o tempo de envio do e-mail

    // Finaliza o envio de e-mail
    setState(() {
      _isSendingEmail = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recovery email sent!'), // Mensagem de sucesso
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacementNamed(context, '/login'); // Navega para a página de login
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
                image: AssetImage('assets/images/img_3.png'), // Caminho da imagem de fundo
                fit: BoxFit.cover, // Ajusta a imagem para cobrir a tela
                alignment: Alignment.center,
              ),
            ),
          ),
          // Conteúdo principal da página
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white.withOpacity(0.8), // Fundo translúcido do card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                ),
                child: Padding(
                  padding:  EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Título da página
                      Text(
                        'Recover the access key',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Subtítulo explicativo
                      Text(
                        'Please enter the e-mail address associated with your account to regain access.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Campo de entrada para o e-mail
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail :',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), // Bordas arredondadas
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      // Botão de enviar e-mail ou indicador de carregamento
                      _isSendingEmail
                          ? CircularProgressIndicator() // Indicador de carregamento
                          : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal, // Cor do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Botão arredondado
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40), // Espaçamento interno
                        ),
                        onPressed: _sendEmail,
                        child: Text(
                          'Send E-mail', // Texto do botão
                          style: TextStyle(
                              fontSize: 18, color: Colors.white), // Estilo do texto
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Ícone de retorno à página inicial
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding:  EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context); // Retorna para a página anterior
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle, // Forma circular
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2), // Sombra para destacar o ícone
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.home, // Ícone de casa
                    color: Colors.black,
                    size: 35, // Tamanho do ícone
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
