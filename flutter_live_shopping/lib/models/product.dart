import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  @JsonKey(name: 'salePrice')
  final double? salePrice;
  final List<String> images;
  final String? thumbnail;
  final int stock;
  final Map<String, dynamic>? variations;
  @JsonKey(name: 'isFeatured')
  final bool isFeatured;
  @JsonKey(name: 'featuredAt')
  final DateTime? featuredAt;
  final String category;
  final double rating;
  @JsonKey(name: 'reviewsCount')
  final int reviewsCount;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.salePrice,
    required this.images,
    this.thumbnail,
    required this.stock,
    this.variations,
    required this.isFeatured,
    this.featuredAt,
    required this.category,
    required this.rating,
    required this.reviewsCount,
  }) {
    _validate();
  }

  void _validate() {
    if (id.isEmpty) {
      throw ArgumentError('Product id cannot be empty');
    }
    if (name.isEmpty) {
      throw ArgumentError('Product name cannot be empty');
    }
    if (description.isEmpty) {
      throw ArgumentError('Product description cannot be empty');
    }
    if (price < 0) {
      throw ArgumentError('Product price cannot be negative');
    }
    if (salePrice != null && salePrice! < 0) {
      throw ArgumentError('Product salePrice cannot be negative');
    }
    if (salePrice != null && salePrice! >= price) {
      throw ArgumentError('Product salePrice must be less than price');
    }
    if (images.isEmpty) {
      throw ArgumentError('Product must have at least one image');
    }
    if (stock < 0) {
      throw ArgumentError('Product stock cannot be negative');
    }
    if (rating < 0 || rating > 5) {
      throw ArgumentError('Product rating must be between 0 and 5');
    }
    if (reviewsCount < 0) {
      throw ArgumentError('Product reviewsCount cannot be negative');
    }
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  /// Factory pour créer un Product depuis les données de test (mock-api-data.json)
  /// Prend un Map correspondant à un objet product du JSON
  factory Product.fromTestData(Map<String, dynamic> json) {
    return Product.fromJson(json);
  }

  double get currentPrice => salePrice ?? price;

  bool get isOnSale => salePrice != null;
}
