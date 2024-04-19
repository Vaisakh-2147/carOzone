import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget titleLogo() {
  return RichText(
    text: TextSpan(
      style: GoogleFonts.roboto(
        color: Colors.white,
        fontStyle: FontStyle.italic,
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
      children: const <TextSpan>[
        TextSpan(text: 'car'),
        TextSpan(
          text: 'O',
          style: TextStyle(
            color: Colors.yellow,
          ),
        ),
        TextSpan(text: 'zone'),
      ],
    ),
  );
}

Widget subtitle(
  String text,
  double fontSize, {
  Color textColor = const Color.fromARGB(255, 255, 255, 255),
}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.roboto(
      color: textColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget textFormFieldWidget({
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required String hintText,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    autofocus: false,
    validator: validator,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customBorderColor(),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.white),
      ),
      fillColor: customBlueColor(),
      filled: true,
      hintText: hintText,
    ),
    keyboardType: keyboardType,
    obscureText: obscureText,
    maxLines: maxLines,
  );
}

Color customBlueColor() {
  return const Color.fromARGB(217, 217, 217, 217);
}

Color customBorderColor() {
  return const Color.fromARGB(255, 68, 255, 239);
}

Widget loginSigninButton({
  required VoidCallback onPressed,
  required String buttonText,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: Text(
      buttonText,
      style: GoogleFonts.oswald(
        fontSize: 23,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

SnackBar createCustomSnackBar({
  required String text,
  required Color backgroundColor,
}) {
  return SnackBar(
    backgroundColor: backgroundColor,
    content: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}

BoxDecoration getGradientDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 2, 79, 86),
        Color.fromARGB(255, 4, 4, 4),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

Widget customtext(String text, double fontSize,
    {Color textColor = const Color.fromARGB(255, 255, 255, 255)}) {
  return Text(
    text,
    textAlign: TextAlign.justify,
    style: TextStyle(
      color: textColor,
      fontSize: fontSize,
    ),
  );
}
