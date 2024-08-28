import 'package:product_catalog/view/view.dart';

class ProductImageContainer extends StatelessWidget {
  final bool isStatic;
  final String imageUrl;

  const ProductImageContainer(
      {super.key, required this.isStatic, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10
      ),
      child: Container(
        width: 200,
        color: primaryColor,
        child: Image(
          fit: BoxFit.cover,
          image: isStatic
              ? AssetImage(imageUrl)
              : FileImage(
                  File(imageUrl),
                ),
        ),
      ),
    );
  }
}
