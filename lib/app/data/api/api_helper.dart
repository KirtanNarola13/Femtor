import 'dart:convert';

import 'package:femtor/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Helper class to handle dummy API calls and simulate network latency.
/// It also interacts with SharedPreferences to cache data as requested.
class ApiHelper {
  // Simulate a network call to login
  Future<Map<String, dynamic>> login(String email, String password) async {
    print("Calling Dummy Login API...");
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Dummy success response
    final response = {
      'status': 'success',
      'token': 'dummy_auth_token_12345',
      'user': {
        'id': 'user_01',
        'name': 'Jane Doe',
        'email': 'jane.doe@example.com',
      },
    };

    // Save to SharedPreferences as requested
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.keyAuthToken,
      response['token'] as String,
    );
    await prefs.setString(
      AppConstants.keyUserData,
      json.encode(response['user']),
    );

    print("Dummy Login Successful. Data saved to SharedPreferences.");
    return response;
  }

  // Simulate fetching data and caching it
  Future<List<Map<String, dynamic>>> getMakeupCourses() async {
    print("Calling Dummy Get Courses API...");
    final prefs = await SharedPreferences.getInstance();

    // First, try to get from cache
    String? cachedCourses = prefs.getString('makeup_courses');
    if (cachedCourses != null) {
      print("Found courses in cache. Returning cached data.");
      // Note: json.decode returns List<dynamic>, so we cast it.
      return List<Map<String, dynamic>>.from(json.decode(cachedCourses));
    }

    // If not in cache, simulate fetching from network
    print("No cache found. Simulating network fetch...");
    await Future.delayed(const Duration(seconds: 3));

    final responseData = [
      {'id': 'course_101', 'title': 'Bridal Makeup Masterclass'},
      {'id': 'course_102', 'title': 'Everyday Natural Look'},
      {'id': 'course_103', 'title': 'Advanced Contouring'},
    ];

    // Save to SharedPreferences for next time
    await prefs.setString('makeup_courses', json.encode(responseData));
    print("Fetched courses and saved to cache.");

    return responseData;
  }

  // Simulate OTP verification
  Future<Map<String, dynamic>> verifyOtp(String otp) async {
    print("Calling Dummy Verify OTP API...");
    await Future.delayed(const Duration(seconds: 2));

    // ✅ Check only valid OTPs
    if (otp != "123456" && otp != "456789") {
      return {'status': 'error', 'message': 'Invalid OTP'};
    }

    // ✅ 456789 = New User
    final isNewUser = otp == "456789";

    if (isNewUser) {
      print("Dummy API: New user detected.");
      return {'status': 'success', 'user_exists': false};
    } else {
      print("Dummy API: Existing user found.");
      return {
        'status': 'success',
        'user_exists': true,
        'user_data': {
          'id': 'user_02',
          'name': 'Omkrushna',
          'mobile_number': '9725305812',
          'email_address': 'omkrushnabhuva07@gmail.com',
          'gender': 'Male',
          'profile_picture': '',
        },
        'token': 'dummy_auth_token_67890',
      };
    }
  }
}
