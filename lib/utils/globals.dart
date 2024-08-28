import 'package:flutter_svg/svg.dart';
import 'package:product_catalog/view/view.dart';
import 'package:provider/single_child_widget.dart';


class Globals {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  static ThemeData appTheme = ThemeData(
    useMaterial3: false,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
    ),
  );
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ProductViewModel()),
  ];

  static Widget loadSvgImage(String assetPath, double? width, double? height, [Color? color]) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }
}
