import 'package:product_catalog/utils/util.dart';

class ProductFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final InputBorder? border;
  final TextStyle? labelStyle;
  final bool? enabled;
  final TextInputType? keyboardType;
  final String label;

  const ProductFormField({
    super.key,
    required this.controller,
    required this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.border,
    this.labelStyle,
    this.enabled,
    this.keyboardType,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: StyledText(
            text: label,
            fontName: "Open Sans",
            color: Colors.black,
          ),
        ),
        4.spaceHeight(),
        TextFormField(

          controller: controller,
          enabled: enabled,
          style: const TextStyle(color: Colors.black),
          obscureText: obscureText ?? false,

          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorStyle: const TextStyle(color: Colors.white),
            fillColor:
                const Color.fromARGB(255, 184, 180, 180).withOpacity(0.2),
            filled: true,
            labelStyle: GoogleFonts.openSans(),
            border: InputBorder.none,
          ),
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
