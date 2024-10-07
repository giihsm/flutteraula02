import 'package:flutter/material.dart';
import 'package:flutteraula02/screens/gadgets_screen.dart';
import 'package:flutteraula02/screens/home_screen.dart';
import 'package:flutteraula02/screens/user_profile_screen.dart';
import 'data/app_data_inherited_widget.dart';
import 'data/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> gadgets = [];

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeColor: Colors.blueGrey,
      child: AppDataInheritedWidget(
        gadgets: gadgets,
        addGadget: (String gadget) {
          gadgets.add(gadget);
        },
        child: MaterialApp(
          title: 'Tech App',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            '/gadgets': (context) => GadgetsScreen(),
            '/userProfile': (context) => UserProfileScreen(),
          },
        ),
      ),
    );
  }
}