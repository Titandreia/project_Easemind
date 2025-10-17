import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HelpSupportPage.dart'; // Página de Ajuda e Suporte
import 'privacy_page.dart'; // Página de Privacidade
import 'About_page.dart'; // Página Sobre
import 'language_page.dart'; // Página de Configurações de Idioma

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Função para mostrar um diálogo de confirmação para excluir a conta
  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    // Verifica se o utilizador está autenticado
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user is logged in.')),
      );
      return;
    }

    bool confirm = false;

    // Mostra uma caixa de diálogo para confirmação da exclusão
    confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text(
            'Are you sure you want to delete your account? This action is irreversible.'),
        actions: [
          // Botão para cancelar a ação
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          // Botão para confirmar a exclusão
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ) ?? false;

    // Caso o utilizador confirme a exclusão
    if (confirm) {
      try {
        await user.delete();
        // Redireciona para a página inicial após a exclusão
        Navigator.pushReplacementNamed(context, '/');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account successfully deleted.')),
        );
      } on FirebaseAuthException catch (e) {
        // Caso a conta precise de reautenticação
        if (e.code == 'requires-recent-login') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'You must log in again to delete the account.')),
          );
        } else {
          // Trata outros erros do Firebase
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting account: ${e.message}')),
          );
        }
      } catch (e) {
        // Trata erros inesperados
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com imagem e filtro
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_2.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.5),
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Cabeçalho da página
                Container(
                  height: 80,
                  color: Colors.white.withOpacity(0.7),
                  child: Center(
                    child: Text(
                      'SETTINGS', // Título da página
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80), // Espaço entre cabeçalho e os botões
                // Lista de botões para as configurações
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      // Botão para configurar Idioma
                      SettingsButton(
                        label: 'Language',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LanguageSettingsScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      // Botão para Ajuda e Suporte
                      SettingsButton(
                        label: 'Help and Support',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpSupportPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      // Botão para Configurações de Privacidade
                      SettingsButton(
                        label: 'Privacy',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      // Botão Sobre a Aplicação
                      SettingsButton(
                        label: 'About',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      // Botão para terminar sessão (Logout)
                      ElevatedButton(
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Logout'),
                              content: Text('Are you sure you want to log out?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ) ?? false;

                          if (confirm) {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushReplacementNamed(context, '/');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('You have been logged out.')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          side: BorderSide(color: Colors.red, width: 2),
                        ),
                        child: Text(
                          'LOG OUT',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Botão para excluir a conta
                      ElevatedButton(
                        onPressed: () => _showDeleteConfirmationDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.withOpacity(0.8),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          side: BorderSide(color: Colors.red, width: 2),
                        ),
                        child: Text(
                          'DELETE ACCOUNT',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Botão de Home no canto inferior direito
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/home_page');
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Botão genérico para configurações
class SettingsButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  SettingsButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.8),
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        side: BorderSide(color: Colors.black, width: 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
