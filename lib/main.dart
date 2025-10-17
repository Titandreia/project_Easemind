import 'package:easemind_trabalho_final/psychologist_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Suporte para internacionalização
import 'package:flutter/services.dart'; // Controle de orientações
import 'firebase_options.dart'; // Configuração do Firebase

// Importação das páginas do projeto
import 'about_page.dart';
import 'login_page.dart';
import 'home_page.dart' as home;
import 'create_account.dart';
import 'forgot_password.dart';
import 'my_account.dart';
import 'diary_page.dart';
import 'appointment_page.dart';
import 'evolution_page.dart';
import 'settings_page.dart';
import 'questions_page.dart';
import 'privacy_page.dart';
import 'notifications_page.dart';
import 'language_page.dart';
import 'make_appointment.dart';
import 'start_consult.dart';

// Classe para gerenciar o idioma do aplicativo
class AppLanguageProvider extends ChangeNotifier {
  Locale _appLocale = Locale('en'); // Idioma padrão inicial: Inglês

  Locale get appLocale => _appLocale; // Getter para acessar o idioma atual

  // Método para alterar o idioma
  void changeLanguage(Locale newLocale) {
    if (_appLocale != newLocale) {
      _appLocale = newLocale; // Atualiza o idioma
      notifyListeners(); // Notifica os widgets que dependem do idioma
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante a inicialização antes de executar qualquer código
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Configurações específicas para a plataforma Firebase
  );

  // Permitir todas as orientações de tela (retrato e paisagem)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppLanguageProvider(), // Inicializa o gerenciador de idioma
      child: MyApp(),
    ),
  );
}

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguageProvider>(
      // Monitoriza mudanças no idioma
      builder: (context, languageProvider, _) {
        return MaterialApp(
          locale: languageProvider.appLocale, // Define o idioma atual
          localizationsDelegates: [
            AppLocalizations.delegate, // Suporte para traduções no projeto
            GlobalMaterialLocalizations.delegate, // Suporte para widgets do Material Design
            GlobalWidgetsLocalizations.delegate, // Suporte para widgets de texto e layout
            GlobalCupertinoLocalizations.delegate, // Suporte para widgets do iOS
          ],
          supportedLocales:  [
            Locale('en'), // Inglês
            Locale('pt'), // Português
          ],
          title: 'EaseMind', // Título do aplicativo
          debugShowCheckedModeBanner: false, // Remove a marca de debug no canto da tela
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), // Esquema de cores baseado em "teal"
            useMaterial3: true, // Ativa o Material Design 3
          ),
          home: /. , // AuthStateHandler() Define a página inicial baseada no estado de autenticação
          routes: {
            '/create_account': (context) => CreateAccountPage(), // Página de criação de conta
            '/forgot_password': (context) => RecoverPasswordPage(), // Página de recuperação de senha
            '/home_page': (context) => home.HomePage(), // Página principal do aplicativo
            '/my_account': (context) => MyAccountPage(), // Página de informações do utilizador
            '/diary_page': (context) => DiaryPage(), // Página do diário
            '/appointment_page': (context) => AppointmentPage(), // Página de marcações
            '/psychologist_page': (context) => PsychologistPage(), // Página para informações de psicólogos
            '/evolution_page': (context) => EvolutionPage(), // Página para acompanhar evolução
            '/settings_page': (context) => SettingsPage(), // Página de configurações
            '/questions_page': (context) => QuestionsPage(), // Página de perguntas frequentes
            '/privacy_page': (context) => PrivacyPage(), // Página de privacidade
            '/notifications_page': (context) => NotificationsPage(), // Página de notificações
            '/language_page': (context) => LanguageSettingsScreen(), // Página de configurações de idioma
            '/about_page': (context) => AboutPage(), // Página "Sobre"
            '/make_appointment': (context) => MakeAppointmentPage(), // Página para criar uma marcação
            '/start_consult': (context) => StartConsultPage(), // Página para iniciar uma consulta
          },
        );
      },
    );
  }
}

// Handler para verificar o estado de autenticação do utilizador
class AuthStateHandler extends StatelessWidget {
  AuthStateHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // Escuta mudanças no estado do utilizador
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  SplashScreen(); // Exibe a tela de carregamento enquanto verifica o estado
        }
        return snapshot.hasData
            ? home.HomePage() // Se autenticado, navega para a página inicial
            : LoginPage(); // Caso contrário, exibe a página de login
      },
    );
  }
}

// Tela de carregamento exibida enquanto verifica o estado de autenticação
class SplashScreen extends StatelessWidget {
   SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Indicador de progresso
      ),
    );
  }
}
