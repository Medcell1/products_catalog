
import 'package:product_catalog/utils/util.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isStatic;
  final double? oldPrice;
  final VoidCallback onTap;
  final dynamic onDelete;

  const ProductCard({
    super.key,
    required this.product,
    this.isStatic = true,
    this.oldPrice,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool proceed = false;

  setProceedToTrue() {
    proceed = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: widget.product.id,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.isStatic
                            ? AssetImage(widget.product.imageUrls[0])
                            : FileImage(File(widget.product.imageUrls[0])),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                if (!widget.isStatic)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        CustomAlert.showAlert(
                          context,
                          "Are you sure you want to proceed with this action?",
                          Image.asset(
                            questionSign,
                            height: 50,
                          ),
                          withButton: true,
                          buttonText: "Yes!",
                          buttonOnTapped: widget.onDelete,
                        );
                      },
                      child: const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(widget.product.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('\$${widget.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              if (widget.oldPrice != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '\$${widget.oldPrice!.toStringAsFixed(2)}',
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
