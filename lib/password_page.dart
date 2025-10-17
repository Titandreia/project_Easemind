import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import para suporte a traduções

// Página para alteração de password
class PasswordPage extends StatelessWidget {
  // Controlador para o campo de texto do e-mail
  final TextEditingController _emailController = TextEditingController();

  // Função para mostrar o diálogo de confirmação ao enviar o e-mail
  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Título do diálogo
          title: Text(AppLocalizations.of(context)!.change_password),
          // Mensagem de confirmação
          content: Text(AppLocalizations.of(context)!.change_password_request),
          actions: [
            // Botão para cancelar
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text(AppLocalizations.of(context)!.no),
            ),
            // Botão para confirmar
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                // Exibe uma notificação de sucesso
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(AppLocalizations.of(context)!.password_email_sent)),
                );
              },
              child: Text(AppLocalizations.of(context)!.yes),
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
          // Fundo com uma imagem e filtro de opacidade
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_2.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4),
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          // Conteúdo principal da página
          SafeArea(
            child: Column(
              children: [
                // Cabeçalho com o título "Password"
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white.withOpacity(0.8),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.password, // Texto traduzido
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 200),
                // Instruções para alteração da password
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    AppLocalizations.of(context)!.password_instructions, // Texto traduzido
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                // Campo de texto para o e-mail
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.email_address, // Texto traduzido
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                ),
                SizedBox(height: 30),
                // Botão para enviar o e-mail de recuperação
                ElevatedButton(
                  onPressed: () => _showSaveDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Fundo branco
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Bordas arredondadas
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    side: BorderSide(color: Color(0xFF21364E), width: 1.5), // Borda personalizada
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.send_email, // Texto traduzido
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
        ],
      ),
    );
  }
}
