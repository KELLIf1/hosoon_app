import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Weekly memorization rate options
  final List<String> options = [
    'Quarter',
    'Half',
    'One Hizb',
    'One and a Half',
    'Two Hizb',
  ];

  // Default selected option (One Hizb)
  int selectedIndex = 2;

  static const Color primaryColor = Color(0xFF031634);
  static const Color primaryContainer = Color(0xFF1A2B4A);
  static const Color outlineVariant = Color(0xFFC5C6CF);
  static const Color surfaceContainer = Color(0xFFEFEDF0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECF0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Progress indicator
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'STEP 1 OF 1',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'How much do you want to memorize per week?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'You can change this anytime later.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),
              // Selection list
              Expanded(
                child: ListView.separated(
                  itemCount: options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final bool isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: isSelected ? primaryColor : outlineVariant,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primaryContainer
                                    : surfaceContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.layers,
                                color: isSelected ? Colors.white : primaryColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                options[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : primaryColor,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_circle, color: Colors.white),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Start button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: save options[selectedIndex] to Hive once the
                    // settings box is ready (e.g. settingsBox.put('weeklyRate', ...))

                    // pushReplacementNamed so the user can't swipe/back into
                    // Onboarding again after finishing it
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
