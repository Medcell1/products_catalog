
import 'view.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final bool isStatic;

  const ProductDetailsScreen(
      {super.key, required this.product, required this.isStatic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, isStatic),
              10.spaceHeight(),
              _buildProductImages(product, isStatic),
              _buildProductInfo(product),
              _buildSizeSelector(),
              _buildColorSelector(),
              _buildQuantitySelector(),
              _buildDescription(product),
              _buildAddToBagButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isStatic) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: primaryColor,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          if (!isStatic)
            CircleAvatar(
              backgroundColor: primaryColor,
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () {
                  pushLeftToRight(
                    context,
                    ProductFormScreen(
                      product: product,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductImages(Product product, bool isStatic) {
    return SizedBox(
      height: 300,
      child: product.imageUrls.length < 2
          ? Center(
              child: Hero(
                tag: product.id,
                child: ProductImageContainer(
                  isStatic: isStatic,
                  imageUrl:
                      product.imageUrls.isNotEmpty ? product.imageUrls.first : '',
                ),
              ),
            )
          : Hero(
              tag: product.id,
              child: ListView.builder(
                itemCount: product.imageUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final imageUrl = product.imageUrls[index];
                  return ProductImageContainer(
                    isStatic: isStatic,
                    imageUrl: imageUrl,
                  );
                },
              ),
            ),
    );
  }

  Widget _buildProductInfo(Product product) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText(
            text: product.name,
            fontName: "Open Sans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          StyledText(
            text: "\$${product.price}",
            fontName: "Poppins",
            fontSize: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(30)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyledText(
              text: "Size",
              fontName: "Open Sans",
              fontSize: 18,
            ),
            Icon(
              Icons.arrow_drop_down_sharp,
              size: 26,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const StyledText(
              text: "Color",
              fontName: "Open Sans",
              fontSize: 18,
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.green[200],
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const StyledText(
              text: "Quantity",
              fontName: "Open Sans",
              fontSize: 18,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: primaryColor,
                  child: IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {},
                    color: Colors.purple,
                  ),
                ),
                10.spaceWidth(),
                const StyledText(
                  text: "1",
                  fontName: "Poppins",
                  fontSize: 14,
                ),
                10.spaceWidth(),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: primaryColor,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 18,
                    ),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(Product product) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StyledText(fontName: "Montserrat", text: product.description),
    );
  }

  Widget _buildAddToBagButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 80,
          ),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const StyledText(
            text: "Add To Bag",
            fontName: "Open Sans",
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
