import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final List<String> imageUrls;
@HiveField(6)
final double? oldPrice;
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.imageUrls,
    this.oldPrice,
  });
  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    double? price,
    List<String>? imageUrls,
    double? oldPrice,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrls: imageUrls ?? this.imageUrls,
      oldPrice: oldPrice ?? this.oldPrice,
    );
  }
}
