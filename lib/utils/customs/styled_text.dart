import 'package:product_catalog/utils/util.dart';
class StyledText extends StatelessWidget {
  final String text;
  final String? fontName;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;

  const StyledText({
    super.key,
    required this.text,
    this.fontName,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.fontStyle,
    this.textDecoration,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 14,
      color: color ?? Colors.black,
      overflow: TextOverflow.visible,
      fontStyle: fontStyle ?? FontStyle.normal,
      decoration:
      textDecoration ?? TextDecoration.none,
    );

    if (fontName != null) {
      return Text(
        text,
        softWrap: true,
        textAlign: textAlign ?? TextAlign.start,
        style: GoogleFonts.getFont(
          fontName!,
          textStyle: textStyle,
        ),
      );
    } else {
      return Text(
        softWrap: true,
        text,
        style: textStyle,
      );
    }
  }
}