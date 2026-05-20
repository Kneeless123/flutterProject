import 'package:flutter/material.dart';

import 'Home.dart';
import 'Addcomp_screen.dart';
import 'edit_screen.dart';

class FragmentPlaceholder extends StatelessWidget {
  const FragmentPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {

    return Navigator(
      initialRoute: '/',

      onGenerateRoute: (settings) {

        WidgetBuilder builder;

        switch (settings.name) {

          // HOME SCREEN
          case '/':
            builder = (BuildContext context) =>
                const HomeScreen();
            break;

          // ADD SCREEN
          case '/add':
            builder = (BuildContext context) =>
                const AddComplaintScreen();
            break;

          // EDIT SCREEN
          case '/edit':

            final int index =
                settings.arguments as int;

            builder = (BuildContext context) =>
                EditScreen(index: index);

            break;

          // DEFAULT
          default:
            builder = (BuildContext context) =>
                const Scaffold(
                  body: Center(
                    child:
                        Text("Route Not Found"),
                  ),
                );
        }

        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }
}