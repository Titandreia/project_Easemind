import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import necessário para traduções

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PrivacyPage(), // Página inicial definida como PrivacyPage
    );
  }
}

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lista das seções de privacidade com títulos e conteúdos traduzidos
    final privacySections = [
      {
        "title": AppLocalizations.of(context)!.data_collected_title,
        "content": AppLocalizations.of(context)!.data_collected_content,
      },
      {
        "title": AppLocalizations.of(context)!.data_sharing_title,
        "content": AppLocalizations.of(context)!.data_sharing_content,
      },
      {
        "title": AppLocalizations.of(context)!.user_rights_title,
        "content": AppLocalizations.of(context)!.user_rights_content,
      },
      {
        "title": AppLocalizations.of(context)!.data_security_title,
        "content": AppLocalizations.of(context)!.data_security_content,
      },
      {
        "title": AppLocalizations.of(context)!.privacy_contact_title,
        "content": AppLocalizations.of(context)!.privacy_contact_content,
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Fundo com a imagem cobrindo toda a tela
          Positioned.fill(
            child: Image.asset(
              'assets/images/img_2.png', // Certifique-se de que o caminho da imagem está correto
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              // Cabeçalho com o título "Política de Privacidade"
              Container(
                margin: EdgeInsets.only(top: 40), // Espaçamento superior
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.white.withOpacity(0.8), // Fundo branco translúcido
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.privacy_title, // Título traduzido
                  style:TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 50), // Espaçamento entre o cabeçalho e as seções

              // Lista de seções de privacidade
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemCount: privacySections.length, // Número de itens na lista
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8), // Margem entre os itens
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Fundo branco translúcido
                        borderRadius: BorderRadius.circular(10),
                        boxShadow:  [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          privacySections[index]["title"]!, // Título traduzido
                          style:  TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        contentPadding:  EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        onTap: () {
                          // Ao clicar em um item, mostra um diálogo com os detalhes
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(privacySections[index]["title"]!),
                              content: Text(privacySections[index]["content"]!),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(AppLocalizations.of(context)!.close),
                                )
                              ],
                            ),
                          );
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
}
