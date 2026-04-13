import 'package:flutter/material.dart';
import 'package:saglixen/core/extension/contex_extension.dart';

@immutable
final class CustomToast {
  const CustomToast._();

  static OverlayEntry? _activeEntry;

  static Future<void> show(
    BuildContext context,
    String mesaj, {
    bool hata = false,
    bool iconVarMi = true,
  }) async {
    // zaten ekranda varsa hiç gösterme
    if (_activeEntry != null && _activeEntry!.mounted) return;

    final overlay = Overlay.of(context);
    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );

    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 0,
        right: 0,
        child: Center(
          child: FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.3),
                end: Offset.zero,
              ).animate(animation),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: hata
                    ? context.colors.primary
                    : Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (iconVarMi)
                        Icon(
                          hata ? Icons.error : Icons.check_circle,
                          color: Colors.white,
                        )
                      else
                        const SizedBox.shrink(),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          mesaj,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: context.colors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    _activeEntry = entry;

    overlay.insert(entry);
    await animationController.forward();

    Future.delayed(const Duration(seconds: 2), () async {
      await animationController.reverse();
      if (entry.mounted) entry.remove();
      animationController.dispose();
      _activeEntry = null;
    });
  }
}
