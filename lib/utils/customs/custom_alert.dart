import 'package:product_catalog/utils/util.dart';

class CustomAlert {
  final String text;
  final IconData? icon;
  final BuildContext context;

  const CustomAlert({
    required this.text,
    this.icon,
    required this.context,
  });

  static showAlert(
      BuildContext context,
      String firstText,
      Widget icon, {
        bool withButton = false,
        String? buttonText,
        dynamic buttonOnTapped,
        bool showPopIcon = true,
        String secondText = "",
      }) {
    return showDialog(
      barrierDismissible: showPopIcon,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (showPopIcon)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child:  const Icon(
                        Icons.cancel_outlined,
                        size: 25.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              icon,
              const SizedBox(height: 16.0),
              StyledText(
                text: firstText,
                fontName: "Open Sans",
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
              if (secondText == "" && secondText.isNotEmpty)
                ...[
                  const SizedBox(
                    height: 4,
                  ),
                  StyledText(
                    text: secondText,
                    fontName: "Open Sans",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                ],

              if (withButton) ...[
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: buttonOnTapped,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 50,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: StyledText(
                      text: buttonText ?? '',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
