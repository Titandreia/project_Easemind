import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Suporte para traduções

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController; // Controlador para a animação de opacidade
  late Animation<double> _opacityAnimation; // Animação para o efeito fade-in

  bool _showWelcomeMessage = true; // Controla se a mensagem de boas-vindas é exibida
  bool _welcomeMessageDisplayed = false; // Garante que a mensagem é exibida apenas uma vez

  @override
  void initState() {
    super.initState();

    // Inicializa o controlador da animação
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Duração da animação
    );

    // Configura a animação de opacidade
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Curva de entrada e saída suave
      ),
    );

    // Exibe a mensagem de boas-vindas se ainda não foi exibida
    if (!_welcomeMessageDisplayed) {
      _animationController.forward().then((_) {
        Future.delayed( Duration(seconds: 2), () {
          setState(() {
            _showWelcomeMessage = false; // Oculta a mensagem após 2 segundos
            _welcomeMessageDisplayed = true; // Marca a mensagem como exibida
          });
        });
      });
    } else {
      _showWelcomeMessage = false;
    }
  }

  @override
  void dispose() {
    _animationController.dispose(); // Libera recursos do controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar automático
        backgroundColor: Colors.white.withOpacity(0.5), // Fundo translúcido
        iconTheme:IconThemeData(color: Colors.black), // Ícones pretos
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // Ícone de notificações
            onPressed: () {
              Navigator.pushNamed(context, '/notifications_page'); // Navega para a página de notificações
            },
          ),
          IconButton(
            icon: Icon(Icons.person), // Ícone de conta
            onPressed: () {
              Navigator.pushNamed(context, '/my_account'); // Navega para a página da conta
            },
          ),
          IconButton(
            icon: Icon(Icons.settings), // Ícone de configurações
            onPressed: () {
              Navigator.pushNamed(context, '/settings_page'); // Navega para a página de configurações
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fundo com imagem e cor sobreposta
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF89C2BF).withOpacity(0.8), // Cor de fundo
            ),
            child: Image.asset(
              'assets/images/img_2.png', // Caminho para a imagem de fundo
              fit: BoxFit.cover, // Ajusta a imagem para cobrir a tela
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(0.3), // Sobreposição branca translúcida
              colorBlendMode: BlendMode.lighten, // Clareia a imagem
            ),
          ),
          // Mensagem de boas-vindas ou botões principais
          Center(
            child: _showWelcomeMessage
                ? FadeTransition(
              opacity: _opacityAnimation, // Aplica a animação de fade-in
              child: Padding(
                padding: EdgeInsets.only(bottom: 200.0), // Ajusta o posicionamento
                child: Text(
                  AppLocalizations.of(context)!.welcome_message, // Mensagem traduzida
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1.5, // Espaçamento entre letras
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0, // Efeito de sombra
                        color: Colors.black38,
                      ),
                    ],
                  ),
                ),
              ),
            )
                : Padding(
              padding: EdgeInsets.only(top: 130),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Primeira linha de botões
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularButton(
                        label: AppLocalizations.of(context)!.diary, // Texto traduzido
                        imagePath: 'assets/images/diary.png', // Caminho da imagem
                        onPressed: () {
                          Navigator.pushNamed(context, '/diary_page'); // Navega para o diário
                        },
                      ),
                      CircularButton(
                        label: AppLocalizations.of(context)!.appointment, // Texto traduzido
                        imagePath: 'assets/images/appointment.png', // Caminho da imagem
                        onPressed: () {
                          Navigator.pushNamed(context, '/appointment_page'); // Navega para consultas
                        },
                      ),
                    ],
                  ),
                   SizedBox(height: 20), // Espaçamento entre linhas
                  // Segunda linha de botões
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularButton(
                        label: AppLocalizations.of(context)!.psychologist, // Texto traduzido
                        imagePath: 'assets/images/psychologist.png', // Caminho da imagem
                        onPressed: () {
                          Navigator.pushNamed(context, '/psychologist_page'); // Navega para psicólogos
                        },
                      ),
                      CircularButton(
                        label: AppLocalizations.of(context)!.evolution, // Texto traduzido
                        imagePath: 'assets/images/evolution.png', // Caminho da imagem
                        onPressed: () {
                          Navigator.pushNamed(context, '/evolution_page'); // Navega para evolução
                        },
                      ),
                    ],
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

// Botão circular personalizado
class CircularButton extends StatelessWidget {
  final String label; // Texto do botão
  final String imagePath; // Caminho da imagem
  final VoidCallback onPressed; // Função ao clicar no botão

  const CircularButton({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed, // Define a ação ao clicar
          child: Container(
            width: 150, // Largura do botão
            height: 150, // Altura do botão
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Forma circular
              color: Colors.white.withOpacity(0.6), // Fundo translúcido
              border: Border.all(
                color: Colors.teal.shade700, // Cor da borda
                width: 5.0, // Largura da borda
              ),
              boxShadow:  [
                BoxShadow(
                  color: Colors.black26, // Cor da sombra
                  blurRadius: 5, // Intensidade do desfoque
                  offset: Offset(2, 2), // Posição da sombra
                ),
              ],
            ),
            child: Padding(
              padding:  EdgeInsets.all(20.0), // Espaçamento interno
              child: Image.asset(
                imagePath, // Imagem do botão
                fit: BoxFit.contain, // Ajuste da imagem
              ),
            ),
          ),
        ),
         SizedBox(height: 10), // Espaçamento entre botão e texto
        Text(
          label, // Texto do botão
          style:  TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5, // Espaçamento entre letras
          ),
        ),
      ],
    );
  }
}
