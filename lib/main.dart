import 'package:flutter/material.dart';
import 'package:flutter_project_final/db_functions/auth_function.dart';
import 'package:flutter_project_final/models/brandmodel.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/models/usermodel.dart';
import 'package:flutter_project_final/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

const isLoggedIn = 'userLoggedIn';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CarsModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(BrandModelAdapter());
  Hive.registerAdapter(CustomerModelAdapter());
  await Hive.openBox<CarsModel>('cars_ca1');
  await Hive.openBox<UserModel>('user_db');
  await Hive.openBox<CustomerModel>('customer_cu2');
  await Hive.openBox<BrandModel>('brands');

  AuthService authService = AuthService();
  await authService.openBox();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Car Rental App',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            displaySmall: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
