import 'package:carousel_slider/carousel_slider.dart';
import 'package:femtor/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/home_view_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                _buildCustomAppBar(),
                const SizedBox(height: 25),
                _buildCarousel(),
                const SizedBox(height: 24),
                _buildSectionHeader("Coaches", showArrow: true),
                const SizedBox(height: 16),
                _buildCoachesList(),
                const SizedBox(height: 24),
                _buildSectionHeader("Continue Watching"),
                const SizedBox(height: 16),
                _buildContinueWatchingList(),
                const SizedBox(height: 24),
                _buildSectionHeader("Categories"),
                const SizedBox(height: 16),
                _buildCategoriesGrid(),
                const SizedBox(height: 100), // spacing above bottom nav
              ],
            ),
          );
        }
      }),
    );
  }

  /// ---------------- CUSTOM APP BAR ----------------
  Widget _buildCustomAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(Images.icFemtorTextLogo, height: 28),
          GestureDetector(
            onTap: () {
              // Your button tap logic here
              controller.onTryProTapped();
              print('Try Pro button tapped!');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ), // Adjusted padding
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Rounded corners
                gradient: AppColors.buttonGradient,
              ),
              child: const Text(
                // Use const for the Text widget
                'Try Pro',
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontWeight: FontWeight.w600,
                  fontSize: 14, // Adjusted font size to match the image
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- CAROUSEL ----------------
  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),
      items: controller.masterClass.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                i["imageUrl"]!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  /// ---------------- SECTION HEADER ----------------
  Widget _buildSectionHeader(String title, {bool showArrow = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          if (showArrow)
            Icon(Icons.arrow_forward, color: AppColors.primaryColor),
        ],
      ),
    );
  }

  /// ---------------- COACHES LIST ----------------
  Widget _buildCoachesList() {
    return SizedBox(
      height:
          330, // Adjusted height to accommodate image and separate text block
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.coaches.length,
        padding: const EdgeInsets.only(left: 20),
        itemBuilder: (context, index) {
          final coach = controller.coaches[index];
          return Container(
            width: 200, // Fixed width for each coach block
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Rounded corners for the image container
                  child: Image.asset(
                    coach['imageUrl']!,
                    height: 250, // Fixed height for the image
                    width: double
                        .infinity, // Image takes full width of the container
                    fit: BoxFit.cover, // Ensures the image fills the space
                  ),
                ),
                const SizedBox(
                  height: 12,
                ), // Space between image and text block
                // Text Container (no background, floats on main screen background)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coach['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ), // Black text
                    ),
                    const SizedBox(height: 4),
                    Text(
                      coach['title']!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${coach['coursesCount']!}+ Courses available',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ---------------- CONTINUE WATCHING ----------------
  Widget _buildContinueWatchingList() {
    return SizedBox(
      height:
          280, // Increased height to accommodate the progress bar and new text layout
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.continueWatching.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          final item = controller.continueWatching[index];
          // Assuming 'progress' is a double between 0.0 and 1.0, e.g., 0.3 for 30%
          final double progressValue =
              double.parse(item['progress'].toString()) ??
              0.0; // Default to 0.0 if not found

          return Container(
            width: 250, // Fixed width for each item
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.asset(
                        item['imageUrl']!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const Positioned.fill(
                        child: Center(
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 40, // Increased size for better visibility
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Episodes Text
                Text(
                  item['episodes']!, // e.g., "03/10 Episodes"
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(
                  height: 4,
                ), // Space between episodes text and progress bar
                // Progress Indicator
                SizedBox(
                  height: 5, // Height of the progress bar
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    value: progressValue, // Current progress (0.0 to 1.0)
                    backgroundColor: Color(0xFF944E63).withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF944E63),
                    ), // Progress color (matching your brand color)
                  ),
                ),
                const SizedBox(
                  height: 12,
                ), // Space between progress bar and title
                // Title
                Text(
                  item['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4), // Space between title and subtitle
                // Subtitle (Coach Name and Title)
                Text(
                  item['subtitle']!, // e.g., "Anaya Gupta Lipstick Artist..."
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  maxLines: 1, // Ensure subtitle doesn't wrap excessively
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ---------------- CATEGORIES GRID ----------------
  Widget _buildCategoriesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing:
            20, // Increased mainAxisSpacing for more vertical separation
        childAspectRatio:
            0.95, // Adjusted aspect ratio to give more height for text below the image
      ),
      itemCount: controller.categories.length,
      itemBuilder: (context, index) {
        final category = controller.categories[index];
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the start
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                12,
              ), // Rounded corners for the image
              child: Image.asset(
                category['imageUrl']!,
                height: 150, // Fixed height for the image in the grid cell
                width: double.infinity, // Image takes full width
                fit: BoxFit.cover, // Cover the entire space
              ),
            ),
            const SizedBox(height: 8), // Space between image and text
            Text(
              category['title']!,
              style: const TextStyle(
                color: Colors.black, // Category title in black
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 2, // Allow title to wrap if needed
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
