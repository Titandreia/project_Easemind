import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import para traduções
import 'Make_Appointment.dart'; // Import para a página de marcação de consulta
import 'Start_Consult.dart'; // Import para a página de início da consulta

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com imagem e filtro de cor
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_1.png'), // Caminho para a imagem de fundo
                fit: BoxFit.cover, // Ajuste da imagem para cobrir toda a área
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7), // Transparência para clarear a imagem
                  BlendMode.lighten, // Modo de mistura para clarear a imagem
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Cabeçalho com o título "Appointments"
                Container(
                  padding: EdgeInsets.all(16.0), // Espaçamento interno
                  color: Colors.white.withOpacity(0.9), // Fundo translúcido do cabeçalho
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.appointments, // Texto traduzido dinamicamente
                      style: TextStyle(
                        fontSize: 24, // Tamanho da fonte do título
                        fontWeight: FontWeight.bold, // Negrito para destacar
                        color: Colors.black, // Cor do texto
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 200), // Espaçamento entre o cabeçalho e o botão "Make Appointment"

                // Botão "Make Appointment"
                ElevatedButton(
                  onPressed: () {
                    // Navega para a página de marcação de consulta
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MakeAppointmentPage(), // Página de marcação de consulta
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Cor de fundo do botão
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20), // Espaçamento interno do botão
                    shape: StadiumBorder(), // Bordas arredondadas do botão
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.make_appointment, // Texto traduzido dinamicamente
                    style: TextStyle(fontSize: 18, color: Colors.white), // Estilo do texto do botão
                  ),
                ),
                SizedBox(height: 50), // Espaçamento entre os dois botões

                // Botão "Start Consult"
                ElevatedButton(
                  onPressed: () {
                    // Navega para a página de início da consulta
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StartConsultPage(), // Página de início da consulta
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Cor de fundo do botão
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20), // Espaçamento interno do botão
                    shape: StadiumBorder(), // Bordas arredondadas do botão
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.start_consult, // Texto traduzido dinamicamente
                    style: TextStyle(fontSize: 18, color: Colors.white), // Estilo do texto do botão
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
