import 'package:product_catalog/utils/customs/sort_dialog.dart';

import 'view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> categories = {
      'Hoodies': categoryHoodie,
      'Shorts': categoryShort,
      'Shoes': categoryShoe,
      'Bag': categoryBag,
    };

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushLeftToRight(
            context,
            const ProductFormScreen(),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundColor: secondaryColor,
                      backgroundImage: NetworkImage(profile),
                      radius: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.shopping_bag, color: Colors.white),
                    ),
                  ],
                ),
                16.spaceHeight(),
                Consumer<ProductViewModel>(
                  builder: (context, productViewModel, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (query) =>
                                      productViewModel.searchProducts(query),
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Globals.loadSvgImage(filterIcon, 20, 20),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => const SortDialog());

                                },
                              ),
                            ],
                          ),
                        ),
                        if (!productViewModel.isSearching && !productViewModel.isSortingActive) ...[
                          24.spaceHeight(),
                          const StyledText(
                            text: "Categories",
                            fontName: "Open Sans",
                            fontWeight: FontWeight.bold,
                          ),
                          16.spaceHeight(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: categories.entries.map((entry) {
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: secondaryColor,
                                    child: Image(
                                      image: AssetImage(entry.value),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(entry.key,
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                        if (productViewModel.isSortingActive) ...[
                          10.spaceHeight(),
                          productViewModel.buildFilterChips(),
                        ],
                        24.spaceHeight(),
                        const StyledText(
                          text: "Products",
                          fontName: "Open Sans",
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 16),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: productViewModel.products.length,
                          itemBuilder: (context, index) {
                            Product product = productViewModel.products[index];
                            bool isStatic =
                                productViewModel.isProductStatic(product);
                            return ProductCard(
                                product: product,
                                oldPrice: product.price,
                                isStatic: isStatic,
                                onTap: () {
                                  pushLeftToRight(
                                    context,
                                    ProductDetailsScreen(
                                      product: product,
                                      isStatic: isStatic,
                                    ),
                                  );
                                },
                                onDelete: () {
                                  productViewModel.deleteProduct(product.id);
                                  Navigator.pop(context);
                                });
                          },
                        ),
                      ],
                    );
                  },
                ),
                16.spaceHeight(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
