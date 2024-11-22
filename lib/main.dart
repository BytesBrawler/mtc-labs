import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:html' as html;

import 'package:visibility_detector/visibility_detector.dart';

void main() {
  runApp(const MTCLabs());
}

class MTCLabs extends StatelessWidget {
  const MTCLabs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTC Labs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2563EB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        isScrolled = _scrollController.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(),
                ServicesSection(),
                ProductsSection(),
                StatsSection(),
                ContactSection(),
              ],
            ),
          ),
          CustomNavBar(isScrolled: isScrolled),
        ],
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  final bool isScrolled;

  const CustomNavBar({super.key, required this.isScrolled});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: isScrolled ? Colors.white.withOpacity(0.95) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'MTC Labs',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isScrolled ? Colors.black : Colors.white,
            ),
          ),
          Row(
            children: [
              NavItem(title: 'Services', isScrolled: isScrolled),
              NavItem(title: 'Products', isScrolled: isScrolled),
              NavItem(title: 'About', isScrolled: isScrolled),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: const Text('Contact Us'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final bool isScrolled;

  const NavItem({super.key, required this.title, required this.isScrolled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          title,
          style: TextStyle(
            color: isScrolled ? Colors.black87 : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withBlue(200),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'MTC Labs',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().fadeIn().slideY(begin: -0.3),
                const SizedBox(height: 16),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Modern Tech Creations',
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.white70,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Explore Our Solutions'),
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.9,
      size.width,
      size.height * 0.8,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ServicesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'Our Services',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  ServiceCard(
                    icon: Icons.computer,
                    title: 'Custom Software',
                    description:
                        'Tailored solutions for your unique business needs',
                  ),
                  ServiceCard(
                    icon: Icons.cloud,
                    title: 'SaaS Products',
                    description: 'Scalable cloud-based software solutions',
                  ),
                  ServiceCard(
                    icon: Icons.security,
                    title: 'Enterprise Solutions',
                    description:
                        'Secure and robust applications for large organizations',
                  ),
                ]
                    .map((card) => SizedBox(
                          width: constraints.maxWidth > 1200
                              ? (constraints.maxWidth - 48) / 3
                              : constraints.maxWidth > 800
                                  ? (constraints.maxWidth - 24) / 2
                                  : constraints.maxWidth,
                          child: card,
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(32),
        child: Transform.translate(
          offset: isHovered ? const Offset(0, -5) : const Offset(0, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isHovered ? 0.1 : 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  widget.icon,
                  size: 48,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      color: Colors.grey[50],
      child: Column(
        children: [
          const Text(
            'Our Products',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 64),
          CarouselSlider(),
        ],
      ),
    );
  }
}

class CarouselSlider extends StatefulWidget {
  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProductCard(
              title: 'Product ${index + 1}',
              description: 'Amazing product description goes here',
              isActive: _currentPage == index,
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isActive;

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(0, isActive ? 0 : 50, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.category,
            size: 64,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          Wrap(
            spacing: 48,
            runSpacing: 48,
            alignment: WrapAlignment.center,
            children: [
              StatCounter(number: 100, label: 'Clients'),
              StatCounter(number: 50, label: 'Team Members'),
              StatCounter(number: 200, label: 'Projects'),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCounter extends StatefulWidget {
  final int number;
  final String label;

  const StatCounter({
    super.key,
    required this.number,
    required this.label,
  });

  @override
  State<StatCounter> createState() => _StatCounterState();
}
// Continuing from the previous StatCounter class...

class _StatCounterState extends State<StatCounter> {
  int _currentNumber = 0;
  bool _hasAnimated = false;

  void _startAnimation() {
    if (!_hasAnimated) {
      setState(() {
        _currentNumber = widget.number;
        _hasAnimated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('stat-${widget.label}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          _startAnimation();
        }
      },
      child: Column(
        children: [
          TweenAnimationBuilder(
            duration: const Duration(seconds: 2),
            tween: Tween(begin: 0.0, end: _currentNumber.toDouble()),
            builder: (context, double value, child) {
              return Text(
                '${value.toInt()}+',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withBlue(200),
          ],
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Get in Touch',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        label: 'Name',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: _messageController,
                        label: 'Message',
                        maxLines: 5,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your message';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Handle form submission
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Message sent successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Text('Send Message'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      maxLines: maxLines,
      validator: validator,
    );
  }
}

// Add required dependencies to pubspec.yaml:
/*
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^5.1.0
  animated_text_kit: ^4.2.2
  flutter_animate: ^4.2.0
  visibility_detector: ^0.4.0+2
*/