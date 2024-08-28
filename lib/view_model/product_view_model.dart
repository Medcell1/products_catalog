import 'package:product_catalog/utils/customs/styled_text.dart';

import 'view_model.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  final Uuid _uuid = const Uuid();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  List<XFile> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  String selectedCategory = "Hoodies";
  List<String> productsCategories = [
    "Bags",
    "Hoodies",
    "Shorts",
    "Shoes",
  ];

  bool get isSearching => _isSearching;
  bool _isSearching = false;


  void searchProducts(String query) {
    _products = [..._hardcodedProducts, ..._productService.getAllProducts()]; // Resetting to original list
    if (query.isEmpty) {
      _isSearching = false;
    } else {
      _isSearching = true;
      _products = _products.where((product) {
        final productNameLower = product.name.toLowerCase();
        final productCategoryLower = product.category.toLowerCase();
        final productPriceLower = product.price.toString().toLowerCase();
        final queryLower = query.toLowerCase();
        return productNameLower.contains(queryLower) ||
            productCategoryLower.contains(queryLower) ||
            productPriceLower.contains(queryLower);
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _isSearching = false;
    notifyListeners();
  }

  List<Product> _products = [];
  bool _isLoading = false;

  final List<Product> _hardcodedProducts = [
    Product(
      id: "0",
      name: "Men's Harrington Jacket",
      category: "Shoes",
      description:
          'Built for life and made to last, this full-zip corduroy jacket is part of our Nike Life collection. The spacious fit gives you...',
      price: 148,
      imageUrls: [hoodie1],
    ),
    Product(
      id: "1",
      name: "Men's Harrington Jacket",
      category: "Shoes",
      description:
          'Built for life and made to last, this full-zip corduroy jacket is part of our Nike Life collection. The spacious fit gives you...',
      price: 148,
      imageUrls: [hoodie2],
    ),
    Product(
      id: "2",
      name: "Men's Harrington Jacket",
      category: "Shoes",
      description:
          'Built for life and made to last, this full-zip corduroy jacket is part of our Nike Life collection. The spacious fit gives you...',
      price: 148,
      imageUrls: [hoodie3],
    ),
  ];

  ProductViewModel() {
    loadProducts();
  }

  List<Product> get products => _products;

  bool get isLoading => _isLoading;

  void initializeForm(Product? product) {
    if (product != null) {
      productNameController.text = product.name;
      productDescriptionController.text = product.description;
      productPriceController.text = product.price.toString();
      selectedCategory = product.category;
      selectedImages = product.imageUrls.map((url) => XFile(url)).toList();
    }
  }

  bool hasProductChanged(Product existingProduct) {
    final currentImages = selectedImages.map((image) => image.path).toList();
    final existingImages = existingProduct.imageUrls;

    return existingProduct.name != productNameController.text ||
        existingProduct.description != productDescriptionController.text ||
        existingProduct.price != double.parse(productPriceController.text) ||
        existingProduct.category != selectedCategory ||
        !listEquals(currentImages, existingImages);
  }

  Future<void> submitForm(
      BuildContext context, Product? existingProduct) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (existingProduct != null) {
        final box = Hive.box<Product>('products');
        final productInBox = box.get(existingProduct.id);

        if (productInBox != null) {
          if (!hasProductChanged(productInBox)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No changes made to the product')),
            );
            _isLoading = false;
            notifyListeners();
            return;
          }

          final updatedProduct = productInBox.copyWith(
            name: productNameController.text,
            description: productDescriptionController.text,
            price: double.parse(productPriceController.text),
            category: selectedCategory,
            imageUrls: selectedImages.map((image) => image.path).toList(),
          );

          await box.put(existingProduct.id, updatedProduct);
          await loadProducts();
          popMultipleTimes(context, 2);
        } else {
          throw Exception('Product not found in the box');
        }
      } else {
        final newProduct = Product(
          id: _uuid.v4(),
          name: productNameController.text,
          description: productDescriptionController.text,
          price: double.parse(productPriceController.text),
          category: selectedCategory,
          imageUrls: selectedImages.map((image) => image.path).toList(),
        );

        final box = Hive.box<Product>('products');
        await box.put(newProduct.id, newProduct);

        await loadProducts();
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error during form submission: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProducts() async {
    final dbProducts = _productService.getAllProducts();
    _products = [..._hardcodedProducts, ...dbProducts];
    notifyListeners();
  }

  void deleteProduct(String id) async {
    await _productService.deleteProduct(id);
    loadProducts();
  }

  void setSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      selectedImages = images;
      notifyListeners();
    }
  }

  void removeImage(XFile image) {
    selectedImages.remove(image);
    notifyListeners();
  }

  void addImage(XFile image) {
    selectedImages.add(image);
    notifyListeners();
  }

  void popMultipleTimes(BuildContext context, int times) {
    for (int i = 0; i < times; i++) {
      Navigator.pop(context);
    }
  }

  bool isProductStatic(Product product) {
    return int.tryParse(product.id) != null && int.parse(product.id) <= 2;
  }

  ///Sort
  TextEditingController sortNameController = TextEditingController();
  String selectedSortCategory = "Hoodies";
  List<String> sortCategories = [
    "Bags",
    "Hoodies",
    "Shorts",
    "Shoes",
  ];
  double currentPrice = 0;
  bool isSortingActive = false;
  List<String> activeFilters = [];

  setIsSortingActive(bool status) {
    isSortingActive = status;
    notifyListeners();
  }

  addFilter(String value) {
    if (!activeFilters.contains(value)) {
      activeFilters.add(value);
    }
  }

  void sortOffers() {
    _products = [..._hardcodedProducts, ..._productService.getAllProducts()]; // Resetting to original list
    isSortingActive = true;
    notifyListeners();

    if (sortNameController.text.isNotEmpty && !activeFilters.contains("name")) {
      addFilter("name");
    }
    if (selectedSortCategory.isNotEmpty && !activeFilters.contains("category")) {
      addFilter("category");
    }
    if (currentPrice > 0 && !activeFilters.contains("price")) {
      addFilter("price");
    }

    _products = _products.where((product) {
      bool matchesName = activeFilters.contains("name")
          ? product.name.toLowerCase().contains(sortNameController.text.toLowerCase())
          : true;
      bool matchesCategory = activeFilters.contains("category")
          ? product.category == selectedSortCategory
          : true;
      bool matchesPrice = activeFilters.contains("price")
          ? product.price <= currentPrice
          : true;

      return matchesName && matchesCategory && matchesPrice;
    }).toList();

    notifyListeners();
  }

  Widget buildFilterChips() {
    return Wrap(
      spacing: 8.0,
      children: activeFilters.map((filter) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                child: child,
              ),
            );
          },
          child: Chip(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
            key: ValueKey(filter),
            side: BorderSide.none,
            deleteIcon: const Icon(
              Icons.close,
              size: 16,
              color: Colors.white,
            ),
            shadowColor: Colors.black,
            label: StyledText(
              text: filter,
              fontName: "Open Sans",
              color: Colors.white,
            ),
            onDeleted: () {
              removeFilter(filter);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide.none,
            ),
            backgroundColor: primaryColor,
          ),
        );
      }).toList(),
    );
  }

  void removeFilter(String filter) {
    activeFilters.remove(filter);

    if (activeFilters.isEmpty) {
      isSortingActive = false;
    }

    notifyListeners();
  }

}
