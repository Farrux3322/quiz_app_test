import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ui/provider/main_provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, _) {
        return Container(
          height: 75,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavbarItem(title: "Home", svgName: "home", index: 0),
              NavbarItem(title: "Order", svgName: "order", index: 1),
              NavbarItem(title: "Question", svgName: "question", index: 2),
              NavbarItem(title: "Profile", svgName: "person", index: 3),
            ],
          ),
        );
      },
    );
  }
}

class NavbarItem extends StatelessWidget {
  const NavbarItem({
    required this.title,
    required this.svgName,
    required this.index,
    super.key,
  });
  final String svgName;
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, _) {
        return TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            shape: const MaterialStatePropertyAll(CircleBorder()),
          ),
          onPressed: () {
            mainProvider.navbarIndex = index;
          },
          child: SizedBox.square(
            dimension: 30,
            child: SvgPicture.asset(
              "assets/icons/$svgName.svg",
              color:
                  mainProvider.navbarIndex == index ? Colors.blue : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
