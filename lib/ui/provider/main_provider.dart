import 'package:flutter/cupertino.dart';
import 'package:quiz_app/ui/views/home.dart';
import 'package:quiz_app/ui/views/order.dart';
import 'package:quiz_app/ui/views/profile.dart';
import 'package:quiz_app/ui/views/question/question.dart';

class MainProvider extends ChangeNotifier {
  //For bottom navigation bar
  int _initNavbarItemIndex = 0;
  get navbarIndex => _initNavbarItemIndex;
  set navbarIndex(value) {
    _initNavbarItemIndex = value;
    view = views[navbarIndex];
    notifyListeners();
  }

  //For views
  List views = const [
    HomeView(),
    OrderView(),
    QuestionView(),
    ProfileView(),
  ];

  late Widget _view;
  get view => _view;
  set view(value) {
    _view = value;
    print(view);
    notifyListeners();
  }

  MainProvider() {
    initializer();
  }

  void initializer() {
    view = views[navbarIndex];

    notifyListeners();
  }
}
