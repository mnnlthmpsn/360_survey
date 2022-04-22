import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey/components/kError.dart';
import 'package:survey/screens/dashboard.dart';
import 'package:survey/screens/login.dart';
import 'package:survey/screens/signUp.dart';
import 'package:survey/screens/splashScreen.dart';
import 'package:survey/screens/welcome.dart';
import 'package:survey/utils/appTheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const Welcome(),
        '/register': (context) => const SignUp(),
        '/login': (context) => const Login(),
        '/dashboard': (context) => const Dashboard(),
        '/error': (context) => const KError()
      },
    );
  }
}
