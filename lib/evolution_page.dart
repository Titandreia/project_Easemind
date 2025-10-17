import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa o Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Psychologist Evolution', // Título da aplicação
      debugShowCheckedModeBanner: false, // Remove a marca de debug
      theme: ThemeData(
        primarySwatch: Colors.teal, // Define a cor principal
      ),
      home: EvolutionPage(), // Define a página inicial
    );
  }
}

// Página principal para exibir evolução
class EvolutionPage extends StatefulWidget {
  EvolutionPage({Key? key}) : super(key: key);

  @override
  _EvolutionPageState createState() => _EvolutionPageState();
}

class _EvolutionPageState extends State<EvolutionPage> {
  // Listas de meses e anos disponíveis para o dropdown
  final List<String> months = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];
  final List<String> years = ['2023', '2024', '2025'];

  // Variáveis para os valores selecionados
  String selectedMonth = 'Janeiro'; // Mês inicial selecionado
  String selectedYear = '2024'; // Ano inicial selecionado
  String? reportSummary; // Resumo do relatório carregado
  bool isLoading = false; // Indica se os dados estão sendo carregados

  // Função para buscar relatórios no Firestore
  Future<void> fetchReport() async {
    setState(() {
      isLoading = true; // Inicia o carregamento
      reportSummary = null; // Limpa qualquer resumo anterior
    });

    try {
      User? user = FirebaseAuth.instance.currentUser; // Obtém o utilizador atual
      if (user == null) {
        setState(() {
          reportSummary = 'Por favor, faça login para visualizar relatórios.'; // Mensagem de erro
          isLoading = false;
        });
        return;
      }

      String email = user.email ?? 'unknown_email'; // Email do utilizador autenticado

      // Verifica se o utilizador existe
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('reports_evolution')
          .doc(email)
          .get();

      if (!userDoc.exists) {
        setState(() {
          reportSummary = 'Nenhum utilizador encontrado com este email.'; // Mensagem de erro
          isLoading = false;
        });
        return;
      }

      // Busca o relatório do mês e ano selecionados
      DocumentSnapshot reportDoc = await FirebaseFirestore.instance
          .collection('reports_evolution')
          .doc(email)
          .collection('reports')
          .doc('$selectedMonth $selectedYear')
          .get();

      if (!reportDoc.exists) {
        setState(() {
          reportSummary = 'Nenhum relatório encontrado para $selectedMonth $selectedYear.'; // Mensagem de erro
          isLoading = false;
        });
        return;
      }

      // Detalhes do relatório
      String diary = reportDoc['reports_diary'] ?? 'Sem informações do diário disponíveis.';
      String consult = reportDoc['reports_consult'] ?? 'Sem informações de consulta disponíveis.';
      String finalDetails = reportDoc['final_details'] ?? 'Sem detalhes finais disponíveis.';

      setState(() {
        reportSummary = '''
Relatório para $selectedMonth $selectedYear:
- Diário: $diary
- Consulta: $consult
- Detalhes finais: $finalDetails
'''; // Formata o relatório carregado
        isLoading = false; // Finaliza o carregamento
      });
    } catch (e) {
      setState(() {
        reportSummary = 'Ocorreu um erro ao buscar o relatório: $e'; // Mensagem de erro
        isLoading = false;
      });
    }
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
                image: AssetImage('assets/images/img_1.png'), // Caminho da imagem de fundo
                fit: BoxFit.cover, // Ajusta a imagem para cobrir toda a tela
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.6), // Transparência do fundo
                  BlendMode.lighten, // Clareia a imagem
                ),
              ),
            ),
          ),
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
                    'Psychologist Evolution', // Texto do cabeçalho
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 200), // Espaçamento entre o cabeçalho e os dropdowns

                // Dropdown para selecionar o mês
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<String>(
                    value: selectedMonth,
                    decoration: InputDecoration(
                      labelText: 'Selecione o Mês',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      filled: true,
                      fillColor: Colors.white, // Fundo do dropdown
                    ),
                    items: months.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month, style: TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!; // Atualiza o mês selecionado
                      });
                    },
                  ),
                ),
                SizedBox(height: 20), // Espaçamento entre os dropdowns

                // Dropdown para selecionar o ano
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<String>(
                    value: selectedYear,
                    decoration: InputDecoration(
                      labelText: 'Selecione o Ano',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      filled: true,
                      fillColor: Colors.white, // Fundo do dropdown
                    ),
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year, style: TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!; // Atualiza o ano selecionado
                      });
                    },
                  ),
                ),
                SizedBox(height: 20), // Espaçamento antes do botão

                // Botão para buscar relatório
                ElevatedButton(
                  onPressed: isLoading ? null : fetchReport, // Desativa o botão enquanto carrega
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Cor do botão
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white) // Indicador de carregamento
                      : Text(
                    'Buscar Relatório',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 30), // Espaçamento antes do resumo do relatório

                // Exibição do resumo do relatório
                if (reportSummary != null)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white, // Fundo do resumo
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2), // Sombra para dar destaque
                        ),
                      ],
                    ),
                    child: Text(
                      reportSummary!, // Exibe o resumo carregado
                      style: TextStyle(fontSize: 12, color: Colors.black),
                      textAlign: TextAlign.center, // Centraliza o texto
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
