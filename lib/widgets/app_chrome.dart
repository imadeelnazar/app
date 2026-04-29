import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Color hidayatGreen = Color(0xFF1B4D3E);
const Color hidayatTeal = Color(0xFF1BA098);

PreferredSizeWidget hidayatAppBar(
  BuildContext context, {
  required String title,
  bool showBack = true,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(title),
    backgroundColor: hidayatGreen,
    foregroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    elevation: 0,
    leading: showBack
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
          )
        : null,
    actions: actions,
  );
}

class HidayatBottomNav extends StatelessWidget {
  final int currentIndex;

  const HidayatBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: hidayatTeal,
      unselectedItemColor: Colors.grey.shade500,
      showUnselectedLabels: true,
      onTap: (index) {
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            context.go('/home');
            return;
          case 1:
            context.go('/quran');
            return;
          case 2:
            context.go('/duas');
            return;
          case 3:
            context.go('/books');
            return;
          case 4:
            context.go('/ziyaraat');
            return;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          activeIcon: Icon(Icons.menu_book),
          label: 'Quran',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Duas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_outlined),
          activeIcon: Icon(Icons.library_books),
          label: 'Books',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined),
          activeIcon: Icon(Icons.location_on),
          label: 'Ziyaraat',
        ),
      ],
    );
  }
}
