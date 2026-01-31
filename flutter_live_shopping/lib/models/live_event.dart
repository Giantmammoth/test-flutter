import 'package:json_annotation/json_annotation.dart';

part 'live_event.g.dart';

enum LiveEventStatus {
  @JsonValue('scheduled')
  scheduled,
  @JsonValue('live')
  live,
  @JsonValue('ended')
  ended,
}

@JsonSerializable()
class Seller {
  final String id;
  final String name;
  @JsonKey(name: 'storeName')
  final String storeName;
  final String? avatar;

  Seller({
    required this.id,
    required this.name,
    required this.storeName,
    this.avatar,
  }) {
    _validate();
  }

  void _validate() {
    if (id.isEmpty) {
      throw ArgumentError('Seller id cannot be empty');
    }
    if (name.isEmpty) {
      throw ArgumentError('Seller name cannot be empty');
    }
    if (storeName.isEmpty) {
      throw ArgumentError('Seller storeName cannot be empty');
    }
  }

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);

  Map<String, dynamic> toJson() => _$SellerToJson(this);

  /// Factory pour créer un Seller depuis les données de test (mock-api-data.json)
  /// Prend un Map correspondant à un objet seller du JSON
  factory Seller.fromTestData(Map<String, dynamic> json) {
    return Seller.fromJson(json);
  }
}

@JsonSerializable()
class LiveEvent {
  final String id;
  final String title;
  final String description;
  @JsonKey(name: 'startTime')
  final DateTime startTime;
  @JsonKey(name: 'endTime')
  final DateTime? endTime;
  final LiveEventStatus status;
  final Seller seller;
  final List<String> products;
  @JsonKey(name: 'featuredProduct')
  final String? featuredProduct;
  @JsonKey(name: 'viewerCount')
  final int viewerCount;
  @JsonKey(name: 'streamUrl')
  final String? streamUrl;
  @JsonKey(name: 'replayUrl')
  final String? replayUrl;
  @JsonKey(name: 'thumbnailUrl')
  final String? thumbnailUrl;

  LiveEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    this.endTime,
    required this.status,
    required this.seller,
    required this.products,
    this.featuredProduct,
    required this.viewerCount,
    this.streamUrl,
    this.replayUrl,
    this.thumbnailUrl,
  }) {
    _validate();
  }

  void _validate() {
    if (id.isEmpty) {
      throw ArgumentError('LiveEvent id cannot be empty');
    }
    if (title.isEmpty) {
      throw ArgumentError('LiveEvent title cannot be empty');
    }
    if (description.isEmpty) {
      throw ArgumentError('LiveEvent description cannot be empty');
    }
    if (endTime != null && endTime!.isBefore(startTime)) {
      throw ArgumentError(
          'LiveEvent endTime must be after startTime');
    }
    if (viewerCount < 0) {
      throw ArgumentError('LiveEvent viewerCount cannot be negative');
    }
    if (status == LiveEventStatus.live && streamUrl == null) {
      throw ArgumentError('LiveEvent with status live must have a streamUrl');
    }
    if (featuredProduct != null &&
        !products.contains(featuredProduct)) {
      throw ArgumentError(
          'LiveEvent featuredProduct must be in products list');
    }
  }

  factory LiveEvent.fromJson(Map<String, dynamic> json) =>
      _$LiveEventFromJson(json);

  Map<String, dynamic> toJson() => _$LiveEventToJson(this);

  /// Factory pour créer un LiveEvent depuis les données de test (mock-api-data.json)
  /// Prend un Map correspondant à un objet liveEvent du JSON
  factory LiveEvent.fromTestData(Map<String, dynamic> json) {
    return LiveEvent.fromJson(json);
  }

  bool get isLive => status == LiveEventStatus.live;
  bool get isScheduled => status == LiveEventStatus.scheduled;
  bool get isEnded => status == LiveEventStatus.ended;
  bool get hasReplay => replayUrl != null && replayUrl!.isNotEmpty;
}
