import 'package:product_catalog/view/view.dart';

class ProductFormScreen extends StatelessWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
    productViewModel.initializeForm(product);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 18),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              product == null ? "Create a Product" : "Edit Product",
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: StyledText(
                  text: 'Description',
                  fontName: "Open Sans",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              20.spaceHeight(),
              TextField(
                controller: productViewModel.productDescriptionController,
                minLines: 10,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Description',
                  filled: true,
                  fillColor: const Color(0xFFF5F5F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Align(
                alignment: Alignment.centerLeft,
                child: StyledText(
                  text: 'Photos',
                  fontName: "Open Sans",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              15.spaceHeight(),
              productViewModel.selectedImages.isEmpty
                  ? GestureDetector(
                      onTap: () {
                        productViewModel.pickImages();
                      },
                      child: DashedContainer(
                        width: Globals.screenWidth * 0.8,
                        height: 100,
                        color: primaryColor,
                        strokeWidth: 2.0,
                        dashWidth: 6.0,
                        dashSpace: 4.0,
                        child: const Center(
                          child: StyledText(
                            text: "You can select up to 3 images",
                            fontName: "Poppins",
                          ),
                        ),
                      ),
                    )
                  : _buildPhotoRow(productViewModel, context),
              20.spaceHeight(),
              ProductFormField(
                controller: productViewModel.productNameController,
                hintText: "",
                label: 'Product Name',
              ),
              20.spaceHeight(),
              const Align(
                alignment: Alignment.topLeft,
                child: StyledText(text: "Category"),
              ),
              20.spaceHeight(),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: productViewModel.selectedCategory,
                      items: productViewModel.productsCategories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        context.read<ProductViewModel>().selectedCategory =
                            value!;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: const Color(0xFFF5F5F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: productViewModel.productPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Price",
                        filled: true,
                        fillColor: const Color(0xFFF5F5F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.spaceHeight(),
              Center(
                child: GestureDetector(
                  onTap: () => productViewModel.submitForm(context, product),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: productViewModel.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : StyledText(
                            text: product == null
                                ? "Create Offer"
                                : "Update Product",
                            fontName: "Open Sans",
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
              20.spaceHeight(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPhotoRow(ProductViewModel productViewModel, BuildContext context) {
  return Row(
    children: [
      ...productViewModel.selectedImages.map(
        (image) => GestureDetector(
          onTap: () async {
            // Confirm removal
            bool? remove = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Remove Image"),
                  content: const Text("Do you want to remove this image?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Remove"),
                    ),
                  ],
                );
              },
            );
            if (remove ?? false) {
              productViewModel.removeImage(image);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              borderRadius: BorderRadius.circular(8.0),
              elevation: 8,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: FileImage(File(image.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      if (productViewModel.selectedImages.length < 3)
        GestureDetector(
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
              source: ImageSource.gallery,
            );
            if (image != null) {
              productViewModel.addImage(image);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.grey,
              ),
            ),
          ),
        ),
    ],
  );
}
