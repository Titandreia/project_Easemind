import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Classe principal da aplicação
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a marca de debug
      home: QuestionsPage(), // Define a página inicial como QuestionsPage
    );
  }
}

/// Página de perguntas frequentes (FAQ)
class QuestionsPage extends StatelessWidget {
  // Lista de perguntas e respostas
  final List<Map<String, String>> questions = [
    {
      "question": "Are my data safe?",
      "answer": "Yes, your data is safe. The app uses end-to-end encryption to protect your data."
    },
    {
      "question": "Is the app available in other languages?",
      "answer": "Yes, the app is currently available in several languages."
    },
    {
      "question": "Can I choose my psychologist?",
      "answer": "Yes, you can select your psychologist from a list of available professionals."
    },
    {
      "question": "What should I do if I forget my password?",
      "answer": "If you forget your password, click 'Forgot Password' on the login screen to reset it."
    },
    {
      "question": "Can I delete my account?",
      "answer": "Yes, you can delete your account in the settings. This will permanently erase your data."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com imagem decorativa
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_2.png'), // Caminho da imagem de fundo
                fit: BoxFit.cover, // Preenche o fundo da página
              ),
            ),
          ),
          Column(
            children: [
              // Cabeçalho da página
              Container(
                margin: EdgeInsets.only(top: 40), // Espaçamento superior do cabeçalho
                padding: const EdgeInsets.symmetric(vertical: 20), // Padding interno
                color: Colors.white.withOpacity(0.8), // Fundo translúcido
                child: Center(
                  child: Text(
                    'QUESTIONS', // Título do cabeçalho
                    style: TextStyle(
                      fontSize: 24, // Tamanho da fonte
                      fontWeight: FontWeight.bold, // Fonte em negrito
                      color: Colors.black, // Cor do texto
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100), // Espaçamento entre o cabeçalho e a lista
              // Lista de perguntas
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15), // Margem horizontal
                  itemCount: questions.length, // Número de itens na lista
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8), // Espaçamento entre itens
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Fundo translúcido
                        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26, // Cor da sombra
                            blurRadius: 4, // Desfoque da sombra
                            offset: Offset(0, 2), // Deslocamento da sombra
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          questions[index]["question"]!, // Título (pergunta)
                          style: TextStyle(
                            fontSize: 16, // Tamanho da fonte
                            fontWeight: FontWeight.bold, // Fonte em negrito
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12, // Padding interno horizontal
                          vertical: 8, // Padding interno vertical
                        ),
                        onTap: () {
                          // Mostra um diálogo com a resposta quando clicado
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(questions[index]["question"]!), // Pergunta como título
                              content: Text(questions[index]["answer"]!), // Resposta como conteúdo
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context), // Fecha o diálogo
                                  child: const Text('Close'), // Botão para fechar
                                ),
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
