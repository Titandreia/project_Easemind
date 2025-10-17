import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com uma imagem translúcida
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_2.png'), // Caminho para a imagem de fundo
                fit: BoxFit.cover, // Ajusta a imagem para cobrir a tela
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1), // Define a transparência
                  BlendMode.srcOver, // Tipo de mistura de cores
                ),
              ),
            ),
          ),
          // Conteúdo principal da página
          Column(
            children: [
              // Cabeçalho
              Container(
                margin: EdgeInsets.only(top: 40), // Espaçamento superior
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.white.withOpacity(0.8), // Fundo translúcido
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.help_and_support, // Texto traduzido dinamicamente
                  style: TextStyle(
                    fontSize: 24, // Tamanho da fonte
                    fontWeight: FontWeight.bold, // Negrito para destaque
                    color: Colors.black, // Cor do texto
                  ),
                ),
              ),
              SizedBox(height: 200), // Espaçamento entre o cabeçalho e o conteúdo principal

              // Caixa principal com informações de ajuda e suporte
              Center(
                child: Container(
                  padding:  EdgeInsets.all(20), // Espaçamento interno
                  margin:  EdgeInsets.fromLTRB(20, 0, 20, 20), // Margem para centralizar
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), // Fundo translúcido
                    borderRadius: BorderRadius.circular(15), // Bordas arredondadas
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // Cor da sombra
                        blurRadius: 6, // Intensidade do desfoque da sombra
                        offset: Offset(0, 3), // Posição da sombra
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
                    children: [
                      // Ícone de ajuda
                      Icon(
                        Icons.help_outline, // Ícone de "ajuda"
                        size: 50, // Tamanho do ícone
                        color: Colors.black, // Cor do ícone
                      ),
                      SizedBox(height: 10), // Espaçamento entre o ícone e o texto
                      // Texto explicativo sobre o problema
                      Text(
                        AppLocalizations.of(context)!.describe_problem, // Texto traduzido dinamicamente
                        textAlign: TextAlign.center, // Centraliza o texto
                        style: TextStyle(
                          fontSize: 16, // Tamanho da fonte
                          fontWeight: FontWeight.w500, // Peso da fonte (médio)
                        ),
                      ),
                      SizedBox(height: 10), // Espaçamento entre os textos
                      // Endereço de e-mail de suporte
                      Text(
                        AppLocalizations.of(context)!.support_email, // Texto traduzido dinamicamente
                        textAlign: TextAlign.center, // Centraliza o texto
                        style: TextStyle(
                          fontSize: 18, // Tamanho da fonte
                          fontWeight: FontWeight.bold, // Negrito para destaque
                          color: Colors.black, // Cor do texto
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
