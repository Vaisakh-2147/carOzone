import 'package:car_o_zone/functions/functions.dart';
import 'package:flutter/material.dart';

class AboutScreeen extends StatelessWidget {
  const AboutScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, bottom: 15, right: 15, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customtext('About Carozone', 25),
              customtext(
                  '''Welcome to Carozone, your go-to destination for all things cars! carozone is a car reviewing app that brings the magic of cars right to your fingertips. Immerse yourself in the world cars brands, share your thoughts, and discover new favorites with our user-friendly platform.''',
                  15),
              customtext('Key Features:', 25),
              const SizedBox(
                height: 10,
              ),
              customtext('Favorite Movies:', 20),
              customtext(
                  '''◉ Save and organize your favorite cars in one place.
◉ Easily access your go-to cars.''', 15),
              customtext('User Comments:', 20),
              customtext(
                  '''◉ Engage with the car by adding your comments and thoughts.
◉ Read and respond to comments.''', 15),
              customtext('Profile Customization:', 20),
              customtext(
                  '''◉ Personalize your profile with a unique avatar and details.
◉ Showcase your favorite genres and share your cars.''',
                  15),
              customtext('Car Management:', 20),
              customtext('◉Admin Panel:', 20),
              customtext('''◉ Admins can effortlessly add new car to the app.
◉ Update car details and review videos to keep the content fresh.''', 15),
              customtext('◉Content Control:', 20),
              customtext(
                  '''◉Ensure quality content by editing or removing cars as needed.''',
                  15),
              customtext('Meet the Developer:', 20),
              const SizedBox(
                height: 10,
              ),
              customtext('Vaisakh P', 20),
              customtext(
                  'Passionate about technology and cars, Vaisakhp P is the creative mind behind carozone. With a vision to make car reviewing a seamless experience, vaisakh brings innovation and enthusiasm to the app development landscape.',
                  15),
              customtext('Contact Vaisakh p:', 20),
              customtext('''Email: vaisakh2147@gmail.com
''',
                  15)
            ],
          ),
        ),
      ),
    );
  }
}