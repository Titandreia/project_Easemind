import 'package:flutter/material.dart';
import 'edit_account.dart'; // Página para editar a conta
import 'password_page.dart'; // Página para alterar a palavra-passe
import 'home_page.dart'; // Página inicial
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Suporte para internacionalização

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com imagem
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_2.png'), // Imagem de fundo
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4), // Transparência no fundo
                  BlendMode.lighten, // Clareia a imagem
                ),
              ),
            ),
          ),

          // Conteúdo principal da página
          SafeArea(
            child: Column(
              children: [
                // Cabeçalho da página
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white.withOpacity(0.6), // Fundo translúcido
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.my_account, // Texto traduzido para "Minha Conta"
                    style: TextStyle(
                      fontSize: 24, // Tamanho da fonte
                      fontWeight: FontWeight.bold, // Texto em negrito
                      color: Colors.black, // Cor do texto
                    ),
                  ),
                ),

                SizedBox(height: 200), // Espaçamento entre o cabeçalho e os botões

                // Botões "Edit Account" e "Password"
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Botão para editar a conta
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal, // Cor de fundo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80), // Espaçamento interno
                        side: BorderSide(color: Colors.teal.shade700, width: 2), // Borda do botão
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditAccountPage()), // Navega para a página de edição de conta
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.edit_account, // Texto traduzido para "Editar Conta"
                        style: TextStyle(
                          color: Colors.white, // Cor do texto
                          fontSize: 18, // Tamanho da fonte
                          fontWeight: FontWeight.bold, // Texto em negrito
                        ),
                      ),
                    ),

                    SizedBox(height: 30), // Espaçamento entre os botões

                    // Botão para alterar a palavra-passe
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal, // Cor de fundo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80), // Espaçamento interno
                        side: BorderSide(color: Colors.teal.shade700, width: 2), // Borda do botão
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PasswordPage()), // Navega para a página de alteração de palavra-passe
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.password, // Texto traduzido para "Palavra-Passe"
                        style: TextStyle(
                          color: Colors.white, // Cor do texto
                          fontSize: 18, // Tamanho da fonte
                          fontWeight: FontWeight.bold, // Texto em negrito
                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(flex: 3), // Cria espaço flexível entre os elementos
              ],
            ),
          ),

          // Botão "Home" no canto inferior direito
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()), // Navega para a página inicial
                );
              },
              child: Container(
                height: 60, // Altura do botão
                width: 60, // Largura do botão
                decoration: BoxDecoration(
                  color: Colors.white, // Fundo do botão
                  shape: BoxShape.circle, // Forma circular
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Sombra do botão
                      blurRadius: 4, // Intensidade da sombra
                      offset: Offset(2, 2), // Posição da sombra
                    ),
                  ],
                ),
                child: Icon(
                  Icons.home, // Ícone de casa
                  color: Colors.black, // Cor do ícone
                  size: 35, // Tamanho do ícone
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
