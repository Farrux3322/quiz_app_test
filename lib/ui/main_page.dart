import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ui/provider/main_provider.dart';
import 'package:quiz_app/ui/views/question/provider/question_provider.dart';
import 'package:quiz_app/ui/widgets/bottom_navbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => QuestionProvider()),
      ],
      builder: (context, child) {
        return Consumer<MainProvider>(
          builder: (context, mainProvider, _) {
            return Scaffold(
              body: SafeArea(child: mainProvider.view),
              bottomNavigationBar: const BottomNavBar(),
            );
          },
        );
      },
    );
  }
}
