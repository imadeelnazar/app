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
    final currentPath = GoRouterState.of(context).uri.path;
    const items = [
      _BottomNavItem(
        icon: Icons.home_rounded,
        label: 'Home',
        path: '/home',
        colors: [Color(0xFF0F766E), Color(0xFF1BA098)],
      ),
      _BottomNavItem(
        icon: Icons.menu_book_rounded,
        label: 'Quran',
        path: '/quran',
        colors: [Color(0xFF1D4ED8), Color(0xFF38BDF8)],
      ),
      _BottomNavItem(
        icon: Icons.favorite_rounded,
        label: 'Duas',
        path: '/duas',
        colors: [Color(0xFF9D174D), Color(0xFFFB7185)],
      ),
      _BottomNavItem(
        icon: Icons.auto_stories_rounded,
        label: 'Books',
        path: '/books',
        colors: [Color(0xFF92400E), Color(0xFFFBBF24)],
      ),
      _BottomNavItem(
        icon: Icons.location_on_rounded,
        label: 'Ziyaraat',
        path: '/ziyaraat',
        colors: [Color(0xFF115E59), Color(0xFFD4A574)],
      ),
    ];

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE7EFEA)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final selected = currentIndex == index;
            return Expanded(
              child: _ModernBottomNavButton(
                item: item,
                selected: selected,
                onTap: () {
                  if (item.path == currentPath) return;
                  context.go(item.path);
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _BottomNavItem {
  final IconData icon;
  final String label;
  final String path;
  final List<Color> colors;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.path,
    required this.colors,
  });
}

class _ModernBottomNavButton extends StatelessWidget {
  final _BottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _ModernBottomNavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: selected
                ? item.colors.last.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                width: selected ? 34 : 30,
                height: selected ? 34 : 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: selected
                      ? LinearGradient(
                          colors: item.colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: selected ? null : const Color(0xFFF1F5F3),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: item.colors.last.withValues(alpha: 0.34),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  item.icon,
                  size: selected ? 20 : 18,
                  color: selected ? Colors.white : const Color(0xFF6B7771),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? item.colors.first : Colors.grey.shade600,
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
