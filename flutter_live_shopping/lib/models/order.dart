import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class ShippingAddress {
  final String name;
  final String street;
  final String city;
  @JsonKey(name: 'postalCode')
  final String postalCode;
  final String country;

  ShippingAddress({
    required this.name,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.country,
  }) {
    _validate();
  }

  void _validate() {
    if (name.isEmpty) {
      throw ArgumentError('ShippingAddress name cannot be empty');
    }
    if (street.isEmpty) {
      throw ArgumentError('ShippingAddress street cannot be empty');
    }
    if (city.isEmpty) {
      throw ArgumentError('ShippingAddress city cannot be empty');
    }
    if (postalCode.isEmpty) {
      throw ArgumentError('ShippingAddress postalCode cannot be empty');
    }
    if (country.isEmpty) {
      throw ArgumentError('ShippingAddress country cannot be empty');
    }
  }

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);

  /// Factory pour créer un ShippingAddress depuis les données de test (mock-api-data.json)
  /// Prend un Map correspondant à un objet shippingAddress du JSON
  factory ShippingAddress.fromTestData(Map<String, dynamic> json) {
    return ShippingAddress.fromJson(json);
  }
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: 'productId')
  final String productId;
  final String name;
  final int quantity;
  final double price;
  @JsonKey(name: 'selectedVariations')
  final Map<String, dynamic>? selectedVariations;

  OrderItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    this.selectedVariations,
  }) {
    _validate();
  }

  void _validate() {
    if (productId.isEmpty) {
      throw ArgumentError('OrderItem productId cannot be empty');
    }
    if (name.isEmpty) {
      throw ArgumentError('OrderItem name cannot be empty');
    }
    if (quantity <= 0) {
      throw ArgumentError('OrderItem quantity must be greater than 0');
    }
    if (price < 0) {
      throw ArgumentError('OrderItem price cannot be negative');
    }
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  /// Factory pour créer un OrderItem depuis les données de test (mock-api-data.json)
  /// Prend un Map correspondant à un objet orderItem du JSON
  factory OrderItem.fromTestData(Map<String, dynamic> json) {
    return OrderItem.fromJson(json);
  }

  double get total => price * quantity;
}

enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('shipped')
  shipped,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

@JsonSerializable()
class Order {
  final String id;
  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'liveEventId')
  final String? liveEventId;
  final List<OrderItem> items;
  final double subtotal;
  final double shipping;
  final double total;
  final OrderStatus status;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'shippingAddress')
  final ShippingAddress shippingAddress;

  Order({
    required this.id,
    required this.userId,
    this.liveEventId,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.shippingAddress,
  }) {
    _validate();
  }

  void _validate() {
    if (id.isEmpty) {
      throw ArgumentError('Order id cannot be empty');
    }
    if (userId.isEmpty) {
      throw ArgumentError('Order userId cannot be empty');
    }
    if (items.isEmpty) {
      throw ArgumentError('Order must have at least one item');
    }
    if (subtotal < 0) {
      throw ArgumentError('Order subtotal cannot be negative');
    }
    if (shipping < 0) {
      throw ArgumentError('Order shipping cannot be negative');
    }
    if (total < 0) {
      throw ArgumentError('Order total cannot be negative');
    }
    // Vérifier que le total correspond à subtotal + shipping
    final calculatedTotal = subtotal + shipping;
    if ((total - calculatedTotal).abs() > 0.01) {
      throw ArgumentError(
          'Order total must equal subtotal + shipping (difference: ${(total - calculatedTotal).abs()})');
    }
    // Vérifier que le subtotal correspond à la somme des items
    final itemsTotal = items.fold<double>(
        0, (sum, item) => sum + item.total);
    if ((subtotal - itemsTotal).abs() > 0.01) {
      throw ArgumentError(
          'Order subtotal must equal sum of items (difference: ${(subtotal - itemsTotal).abs()})');
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  /// Factory pour créer un Order depuis les données de test (mock-api-data.json)
  /// Prend un Map correspondant à un objet order du JSON
  factory Order.fromTestData(Map<String, dynamic> json) {
    return Order.fromJson(json);
  }
}
