import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import para traduções

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a bandeira de debug
      localizationsDelegates: AppLocalizations.localizationsDelegates, // Configura delegados de localização
      supportedLocales: AppLocalizations.supportedLocales, // Define os idiomas suportados
      home: NotificationsPage(), // Define a página inicial como NotificationsPage
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com imagem translúcida
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_2.png'), // Imagem de fundo
                fit: BoxFit.cover, // Ajusta a imagem para cobrir a tela
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4), // Aplica transparência na imagem
                  BlendMode.lighten, // Clareia a imagem
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Cabeçalho
              Container(
                margin: EdgeInsets.only(top: 50), // Espaçamento superior
                padding: EdgeInsets.symmetric(vertical: 20), // Espaçamento interno
                color: Colors.white.withOpacity(0.8), // Fundo branco translúcido
                alignment: Alignment.center, // Centraliza o texto
                child: Text(
                  AppLocalizations.of(context)!.notifications, // Texto traduzido para "Notificações"
                  style: TextStyle(
                    fontSize: 24, // Tamanho da fonte
                    fontWeight: FontWeight.bold, // Negrito
                    color: Colors.black, // Cor do texto
                  ),
                ),
              ),
              SizedBox(height: 50), // Espaço entre o cabeçalho e o conteúdo

              // Contador de notificações
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos
                  children: [
                    Icon(Icons.notifications, size: 40, color: Colors.black), // Ícone de notificações
                    SizedBox(width: 10),
                    Text(
                      '4', // Número de notificações (estático neste exemplo)
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Lista de notificações
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20), // Espaçamento lateral
                  children: [
                    _buildNotification(
                      icon: Icons.calendar_today, // Ícone para lembrete de consulta
                      message: AppLocalizations.of(context)!.appointment_reminder,
                    ),
                    _buildNotification(
                      icon: Icons.account_circle, // Ícone para novo psicólogo disponível
                      message: AppLocalizations.of(context)!.new_psychologist_available,
                    ),
                    _buildNotification(
                      icon: Icons.book, // Ícone para lembrete do diário
                      message: AppLocalizations.of(context)!.diary_reminder,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Botão de casa no canto inferior direito
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.pop(context); // Retorna para a página anterior
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white, // Fundo branco
                  shape: BoxShape.circle, // Forma circular
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Sombra preta translúcida
                      blurRadius: 4, // Suavidade da sombra
                      offset: Offset(2, 2), // Posição da sombra
                    ),
                  ],
                ),
                child: Icon(
                  Icons.home, // Ícone de casa
                  color: Colors.black, // Cor do ícone
                  size: 30, // Tamanho do ícone
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Função para criar notificações individuais
  Widget _buildNotification({required IconData icon, required String message}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8), // Margem entre os itens
      padding: EdgeInsets.all(16), // Espaçamento interno
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Fundo branco translúcido
        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Sombra preta translúcida
            blurRadius: 6, // Suavidade da sombra
            offset: Offset(0, 3), // Posição da sombra
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.black), // Ícone da notificação
          SizedBox(width: 10), // Espaço entre o ícone e o texto
          Expanded(
            child: Text(
              message, // Texto da notificação
              style: TextStyle(
                fontSize: 16, // Tamanho do texto
                color: Colors.black, // Cor do texto
              ),
            ),
          ),
        ],
      ),
    );
  }
}

