import 'package:flutter/material.dart';
import 'dart:async';

class OnboardingScreen extends StatefulWidget {
  final int currentPage;
  const OnboardingScreen({
    super.key,
    this.currentPage = 0,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _updateTime();
      }
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 34,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            children: [
              // Background Image - AJUSTÉ POUR COMMENCER À 0
              Positioned(
                left: -75,
                top: 0, // ✅ Changé de 38 à 0
                child: Image.asset(
                  'asset/fond.png',
                  width: 549,
                  height: 844, // ✅ Ajusté pour couvrir toute la hauteur
                  fit: BoxFit.cover,
                ),
              ),

              // STATUS BAR AVEC HEURE EN TEMPS RÉEL
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Heure en temps réel
                      Text(
                        _currentTime,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3F3F3F),
                        ),
                      ),

                      // Icônes
                      Row(
                        children: const [
                          Icon(
                            Icons.signal_cellular_alt,
                            size: 18,
                            color: Color(0xFF3F3F3F),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.wifi,
                            size: 18,
                            color: Color(0xFF3F3F3F),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.battery_full,
                            size: 18,
                            color: Color(0xFF3F3F3F),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Logo
              Positioned(
                left: 121,
                top: 90,
                child: Image.asset(
                  'asset/logo.png',
                  width: 129,
                  height: 129,
                  fit: BoxFit.contain,
                ),
              ),

              // Page Indicators
              Positioned(
                left: 0,
                right: 0,
                bottom: 60,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        10,
                            (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == widget.currentPage
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.4),
                            boxShadow: index == widget.currentPage ? [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.5),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ] : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
