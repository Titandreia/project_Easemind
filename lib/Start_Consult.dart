import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/start_consult': (context) => StartConsultPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_1.png'), // Caminho da imagem
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white60, // Opacidade de 0.6
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/start_consult');
              },
              child: Text('Start Consultation'),
            ),
          ),
        ],
      ),
    );
  }
}

class StartConsultPage extends StatefulWidget {
  StartConsultPage({Key? key}) : super(key: key);

  @override
  _StartConsultPageState createState() => _StartConsultPageState();
}

class _StartConsultPageState extends State<StartConsultPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // Simula respostas do "psicólogo IA"
  String _generateResponse(String userInput) {
    userInput = userInput.toLowerCase();

    if (userInput.contains('ola') || userInput.contains('oi') || userInput.contains('bom dia')) {
      return 'Olá! Em que posso ajudar hoje?';
    } else if (userInput.contains('ansioso')) {
      return 'Compreendo. Pode tentar exercícios de respiração ou relaxamento. Quer que eu explique como funcionam?';
    } else if (userInput.contains('triste')) {
      return 'Sinto muito por ouvir isso. Pode compartilhar o que o/a está a deixar assim? Estou aqui para ajudar.';
    } else if (userInput.contains('feliz')) {
      return 'Que ótimo saber disso! O que contribuiu para este momento feliz?';
    } else if (userInput.contains('stress') || userInput.contains('estressado')) {
      return 'O stress pode ser desafiador. Já tentou técnicas de mindfulness ou uma pausa para cuidar de si?';
    } else if (userInput.contains('sofrimento') || userInput.contains('dor emocional')) {
      return 'Entendo que está a passar por algo difícil. Quer partilhar mais para que possamos explorar juntos?';
    } else if (userInput.contains('relaxar') || userInput.contains('calma')) {
      return 'Praticar respiração profunda e reservar momentos para si mesmo pode ajudar. Posso guiar um exercício simples se quiser.';
    } else if (userInput.contains('não sei o que fazer')) {
      return 'Parece que está a sentir-se um pouco perdido/a. Vamos tentar clarificar o que está a incomodar. Quer conversar sobre isso?';
    } else if (userInput.contains('obrigado') || userInput.contains('obrigada')) {
      return 'De nada! Estou aqui sempre que precisar.';
    } else if (userInput.contains('medo')) {
      return 'O medo é natural, mas pode ser útil explorar o que o/a está a causar. Podemos falar sobre isso se quiser.';
    } else if (userInput.contains('ajuda') || userInput.contains('preciso de ajuda')) {
      return 'Claro, estou aqui para ajudar. O que está a passar?';
    } else if (userInput.contains('confuso') || userInput.contains('confusão')) {
      return 'Compreendo. Muitas vezes, organizar os pensamentos pode ajudar. Quer começar a falar sobre o que o/a está a confundir?';
    } else if (userInput.contains('culpa')) {
      return 'Sentir culpa pode ser um peso difícil. Acha que podemos explorar juntos o motivo desse sentimento?';
    } else if (userInput.contains('dormir') || userInput.contains('insónia')) {
      return 'Dificuldades para dormir podem ser frustrantes. Já tentou estabelecer uma rotina antes de dormir? Posso sugerir algumas práticas.';
    } else if (userInput.contains('falar') || userInput.contains('conversar')) {
      return 'Sim, claro. Pode falar livremente. Estou aqui para ouvir.';
    } else if (userInput.contains('autoconfiança') || userInput.contains('inseguro')) {
      return 'Trabalhar a autoconfiança leva tempo. Quer explorar os seus pontos fortes? Isso pode ajudar.';
    } else if (userInput.contains('relacionamento')) {
      return 'Os relacionamentos podem ser complexos. Quer partilhar mais sobre o que está a passar?';
    } else {
      return 'Entendi. Pode contar-me mais sobre isso? Estou aqui para ouvir e ajudar.';
    }
  }


  void _sendMessage() {
    final userInput = _controller.text.trim();
    if (userInput.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'user', 'message': userInput});
        _messages.add({'sender': 'bot', 'message': _generateResponse(userInput)});
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Consult - Chat'),
      ),
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_1.png'), // Caminho da imagem
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white60, // Opacidade de 0.6
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          // Conteúdo do chat
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message['sender'] == 'user';
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue[200] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message['message'] ?? ''),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Digite a sua mensagem...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
