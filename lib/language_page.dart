import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'main.dart'; // Importa o arquivo principal que contém a definição do `AppLanguageProvider`

class LanguageSettingsScreen extends StatelessWidget {
  // Lista de opções de idiomas disponíveis
  final List<Map<String, String>> languageOptions = [
    {
      "title": "Device Language", // Título da opção para a linguagem do dispositivo
      "description":
      "Sets the language of the app to match your device's default language.", // Descrição em inglês
      "locale": "en" // Código da localidade correspondente
    },
    {
      "title": "Português", // Título em português
      "description": "Define o idioma da aplicação como Português.", // Descrição em português
      "locale": "pt" // Código da localidade para português
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo com opacidade ajustada
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/img_2.png'), // Caminho da imagem de fundo
                  fit: BoxFit.cover, // Ajusta a imagem para cobrir toda a tela
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.1), // Aplica transparência à imagem
                    BlendMode.srcOver, // Tipo de mistura de cor
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Cabeçalho da página
              Container(
                margin: EdgeInsets.only(top: 40), // Define a margem superior
                padding: EdgeInsets.symmetric(vertical: 20), // Define o padding interno
                color: Colors.white.withOpacity(0.8), // Fundo translúcido
                alignment: Alignment.center, // Centraliza o conteúdo
                child: Text(
                  AppLocalizations.of(context)?.language ?? 'Language', // Título traduzido dinamicamente
                  style: TextStyle(
                    fontSize: 24, // Tamanho do texto
                    fontWeight: FontWeight.bold, // Negrito para destacar
                    color: Colors.black, // Cor do texto
                  ),
                ),
              ),
              SizedBox(height: 150), // Espaçamento entre o cabeçalho e as opções
              // Lista de idiomas
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15), // Padding interno horizontal
                  itemCount: languageOptions.length, // Número de itens na lista
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8), // Margem entre os itens
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Fundo translúcido
                        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26, // Cor da sombra
                            blurRadius: 4, // Intensidade do desfoque
                            offset: Offset(0, 2), // Posição da sombra
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          languageOptions[index]["title"]!, // Exibe o título do idioma
                          style: TextStyle(
                            fontSize: 16, // Tamanho do texto
                            fontWeight: FontWeight.bold, // Negrito para destacar
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12, // Padding horizontal interno
                          vertical: 8, // Padding vertical interno
                        ),
                        onTap: () {
                          final localeCode = languageOptions[index]["locale"]!;
                          _showConfirmationDialog(context, localeCode);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String localeCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.confirmChange ?? 'Confirm Language Change'),
          content: Text(AppLocalizations.of(context)?.confirmMessage ??
              'Are you sure you want to change the language?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo sem fazer alterações
              },
              child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AppLanguageProvider>(context, listen: false)
                    .changeLanguage(Locale(localeCode));
                Navigator.of(context).pop(); // Fecha o diálogo após confirmar
              },
              child: Text(AppLocalizations.of(context)?.confirm ?? 'Confirm'),
            ),
          ],
        );
      },
    );
  }
}
