import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import para traduções

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa o Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diary Page', // Título do app
      debugShowCheckedModeBanner: false, // Remove a marca de debug
      theme: ThemeData(
        primarySwatch: Colors.teal, // Define a cor principal
      ),
      home: DiaryPage(), // Define a página inicial
      localizationsDelegates: AppLocalizations.localizationsDelegates, // Suporte a múltiplas línguas
      supportedLocales: AppLocalizations.supportedLocales, // Localizações suportadas
    );
  }
}

// Página principal do diário
class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final TextEditingController _entryController = TextEditingController(); // Controlador para entrada de texto
  String selectedDay = '1'; // Dia selecionado
  String selectedMonth = 'January'; // Mês selecionado
  String selectedYear = '2024'; // Ano selecionado

  // Listas de opções para dia, mês e ano
  final List<String> days = List<String>.generate(31, (index) => '${index + 1}');
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<String> years = ['2024','2025'];

  // Função para salvar entrada no Firestore
  Future<void> saveEntry() async {
    if (_entryController.text.isEmpty) return; // Verifica se o campo está vazio

    try {
      User? user = FirebaseAuth.instance.currentUser; // Obtém o utilizador atual
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.please_sign_in)), // Mensagem de erro
        );
        return;
      }

      String email = user.email ?? 'unknown_email';
      String formattedDate = "$selectedDay-$selectedMonth-$selectedYear"; // Data formatada

      // Salva a entrada no Firestore
      await FirebaseFirestore.instance
          .collection('diary_entries')
          .doc(email)
          .collection('entries')
          .doc(formattedDate)
          .set({
        'entry': _entryController.text, // Entrada do utilizador
        'date': formattedDate, // Data formatada
        'timestamp': FieldValue.serverTimestamp(), // Timestamp automático
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.entry_saved_successfully)), // Mensagem de sucesso
      );
      _entryController.clear(); // Limpa o campo de texto
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.error_saving_entry} $e')), // Mensagem de erro
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com imagem
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_1.png'), // Caminho da imagem
                fit: BoxFit.cover, // Ajuste para cobrir toda a área
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.6), // Transparência
                  BlendMode.lighten, // Clareia a imagem
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Cabeçalho
                  Container(
                    margin: EdgeInsets.only(top: 9),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Colors.white.withOpacity(0.8), // Fundo translúcido
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.diary_page_title, // Título traduzido
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Botão para acessar entradas anteriores
                  IconButton(
                    icon: Icon(Icons.folder, size: 30, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DiaryEntriesPage()), // Navega para `DiaryEntriesPage`
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  // Dropdowns para data
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            value: selectedDay,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.day,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            items: days.map((day) {
                              return DropdownMenuItem(value: day, child: Text(day));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedDay = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Flexible(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: selectedMonth,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.month,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            items: months.map((month) {
                              return DropdownMenuItem(value: month, child: Text(month));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedMonth = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Flexible(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            value: selectedYear,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.year,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            items: years.map((year) {
                              return DropdownMenuItem(value: year, child: Text(year));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedYear = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // Campo para entrada do diário
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: _entryController,
                      maxLines: 15,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.write_entry_hint, // Texto de dica
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.95),
                      ),
                    ),
                  ),
                  // Botão para salvar entrada
                  ElevatedButton(
                    onPressed: saveEntry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Cor do botão
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.save_button, // Texto traduzido
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Página de entradas anteriores
class DiaryEntriesPage extends StatefulWidget {
  @override
  _DiaryEntriesPageState createState() => _DiaryEntriesPageState();
}

class _DiaryEntriesPageState extends State<DiaryEntriesPage> {
  Future<List<Map<String, String>>> fetchEntries() async {
    List<Map<String, String>> entries = [];
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return entries;

      String email = user.email ?? 'unknown_email';
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('diary_entries')
          .doc(email)
          .collection('entries')
          .orderBy('timestamp', descending: true)
          .get();

      for (var doc in snapshot.docs) {
        entries.add({
          'date': doc.id,
          'entry': doc['entry'] ?? '',
        });
      }
    } catch (e) {
      print('Erro ao buscar entradas: $e');
    }
    return entries;
  }

  void showEntry(String date, String entry) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${AppLocalizations.of(context)!.entry_for} $date'), // Data da entrada
          content: Text(entry), // Conteúdo da entrada
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.close), // Texto do botão
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.diary_entries_title), // Título da página
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.no_entries_found)); // Mensagem se não houver entradas
          }
          List<Map<String, String>> entries = snapshot.data!;
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              var entry = entries[index];
              return ListTile(
                title: Text(entry['date']!), // Data da entrada
                onTap: () => showEntry(entry['date']!, entry['entry']!), // Mostra entrada ao clicar
              );
            },
          );
        },
      ),
    );
  }
}
