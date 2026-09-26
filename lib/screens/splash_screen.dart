import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/constants/app_constants.dart';
import '../app/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // 12-second animation timeline
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    _controller.forward();

    // Exactly 12 seconds duration requirement (non-negotiable)
    Future.delayed(const Duration(seconds: 12), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.terracotta,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final progress = _controller.value; // 0.0 to 1.0

          // Staggered sequence calculations over 12 seconds
          final pulseScale1 = 1.0 + (math.sin(progress * math.pi * 6) * 0.15);
          final pulseScale2 = 1.0 + (math.cos(progress * math.pi * 6) * 0.20);
          final opacityWordmark = (progress * 4.0).clamp(0.0, 1.0);
          final opacityTagline = ((progress - 0.25) * 4.0).clamp(0.0, 1.0);
          final opacityFooter = ((progress - 0.5) * 3.0).clamp(0.0, 1.0);

          return Stack(
            children: [
              // Background Canvas: Expanding pulse rings & popping sparkles
              CustomPaint(
                painter: FlashySplashPainter(progress: progress),
                size: Size.infinite,
              ),

              // Center Content Layer
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Central Animated Emblem (Lightweight Vector geometry, NO IMAGES)
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer Pulsing Gold Aura Ring
                          Transform.scale(
                            scale: pulseScale2,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTheme.turmericGold.withValues(alpha: 0.35),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          // Inner Pulsing White Ring
                          Transform.scale(
                            scale: pulseScale1,
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          // Core Icon
                          const Icon(
                            Icons.auto_awesome_rounded,
                            size: 56,
                            color: AppTheme.turmericGold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),

                      // Brand Wordmark "KHAAR"
                      Opacity(
                        opacity: opacityWordmark,
                        child: Text(
                          'KHAAR',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 6.0,
                            shadows: [
                              Shadow(
                                color: AppTheme.turmericGold.withValues(alpha: 0.6),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Sub-header "SUNNYVALE"
                      Opacity(
                        opacity: opacityWordmark,
                        child: Text(
                          'SUNNYVALE',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.turmericGold,
                            letterSpacing: 8.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Tagline
                      Opacity(
                        opacity: opacityTagline,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Text(
                            AppConstants.tagline,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withValues(alpha: 0.95),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // 12-second Progress Bar Indicator
                      Opacity(
                        opacity: opacityFooter,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 160,
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.white.withValues(alpha: 0.2),
                                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.turmericGold),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Unlocking Northeast India...',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Colors.white70,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// CustomPainter for lightweight flashy background particle pops & aura bursts
class FlashySplashPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0

  FlashySplashPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.max(size.width, size.height) * 0.7;

    // 1. Expanding Pulse Wave Rings
    final waveCount = 3;
    for (int i = 0; i < waveCount; i++) {
      final waveProgress = (progress * 2.5 + (i / waveCount)) % 1.0;
      final radius = waveProgress * maxRadius;
      final alpha = (1.0 - waveProgress).clamp(0.0, 1.0) * 0.35;

      final paint = Paint()
        ..color = AppTheme.turmericGold.withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(center, radius, paint);
    }

    // 2. Flashy Radial Particles Popping Outwards
    final particleCount = 24;
    final random = math.Random(42); // deterministic seed for smooth continuous motion

    for (int i = 0; i < particleCount; i++) {
      final angle = (i * (2 * math.pi / particleCount)) + (progress * math.pi * 0.5);
      final speed = 150.0 + (random.nextDouble() * 250.0);
      final distance = ((progress * speed * 2) + (i * 15)) % (size.width * 0.45);
      final particleAlpha = (1.0 - (distance / (size.width * 0.45))).clamp(0.0, 1.0) * 0.8;

      final x = center.dx + math.cos(angle) * distance;
      final y = center.dy + math.sin(angle) * distance;
      final particleRadius = 2.0 + (random.nextDouble() * 3.5);

      final particlePaint = Paint()
        ..color = (i % 2 == 0 ? AppTheme.turmericGold : Colors.white).withValues(alpha: particleAlpha)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), particleRadius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant FlashySplashPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
