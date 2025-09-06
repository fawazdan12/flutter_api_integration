import 'package:bloc/config/theme/theme.dart';
import 'package:bloc/core/providers/auth_provider.dart';
import 'package:bloc/injections/injection.dart';
import 'package:bloc/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(); // GetIt

  runApp(
    MultiProvider(
      providers: [
        // AuthProvider vient de GetIt (sl) et appelle les use cases
        ChangeNotifierProvider<AuthProvider>(create: (_) => sl<AuthProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: TAppTheme.lightThemeData(context),
      darkTheme: TAppTheme.darkThemeData(context),
      home: const LoginScreen(),
    );
  }
}