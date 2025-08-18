import 'package:ecommerce_application/authentication/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Frontpage extends StatelessWidget {
  const Frontpage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final bool isSmall = width < 600;
    final bool isMedium = width >= 600 && width < 1024;
    final bool isLarge = width >= 1024;

    // Max content width on large screens so it doesn't look stretched
    final double contentMaxWidth = isLarge ? 900 : (isMedium ? 700 : width);

    // Scaled typography & controls with sensible caps for both small & big screens
    final double headingSize = (width * 0.07).clamp(22.0, 40.0);
    final double nextFontSize = (width * 0.045).clamp(14.0, 20.0);
    final double nextPad = (width * 0.045).clamp(12.0, 20.0);

    // Image height tweaks per breakpoint
    final double imageHeight = isLarge
        ? height * 0.42
        : isMedium
        ? height * 0.48
        : height * 0.52;

    // Page padding scales a bit but is capped
    final double vPad = (height * 0.02).clamp(12.0, 28.0);
    final double hPad = (width * 0.04).clamp(12.0, 32.0);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentMaxWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: vPad, horizontal: hPad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section
                  // Image Section
                  ClipRRect(
                    borderRadius: BorderRadius.circular(isLarge ? 16 : 10),
                    child: AspectRatio(
                      aspectRatio:
                          16 / 9, // keeps nice proportion across all screens
                      child: Image.asset(
                        "assests/images/front.png",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Title
                  Padding(
                    padding: EdgeInsets.only(
                      left: (width * 0.02).clamp(6.0, 18.0),
                      top: (height * 0.02).clamp(10.0, 24.0),
                    ),
                    child: Text(
                      "Bringing The World \nTo Your Doorstep",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.breeSerif(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: headingSize,
                          height: 1.15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: (height * 0.05).clamp(16.0, 40.0)),

                  // Next button (kept as circular & right-aligned)
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Loginpage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(nextPad),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "Next",
                          style: GoogleFonts.breeSerif(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: nextFontSize,
                              fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
