import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ReplyTo {
  final String id;
  final String sender;
  final String message;

  ReplyTo({
    required this.id,
    required this.sender,
    required this.message,
  });

  factory ReplyTo.fromJson(Map<String, dynamic> json) =>
      _$ReplyToFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToToJson(this);
}

@JsonSerializable()
class ChatMessage {
  final String id;
  @JsonKey(name: 'senderId')
  final String senderId;
  @JsonKey(name: 'senderName')
  final String senderName;
  final String message;
  final DateTime timestamp;
  @JsonKey(name: 'isVendor')
  final bool isVendor;
  @JsonKey(name: 'replyTo')
  final ReplyTo? replyTo;
  final List<String> reactions;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.isVendor,
    this.replyTo,
    required this.reactions,
  }) {
    _validate();
  }

  void _validate() {
    if (id.isEmpty) {
      throw ArgumentError('ChatMessage id cannot be empty');
    }
    if (senderId.isEmpty) {
      throw ArgumentError('ChatMessage senderId cannot be empty');
    }
    if (senderName.isEmpty) {
      throw ArgumentError('ChatMessage senderName cannot be empty');
    }
    if (message.isEmpty) {
      throw ArgumentError('ChatMessage message cannot be empty');
    }
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  /// Factory pour créer un ChatMessage depuis les données de test (mock-api-data.json)
  /// Prend un Map correspondant à un objet chatMessage du JSON
  factory ChatMessage.fromTestData(Map<String, dynamic> json) {
    return ChatMessage.fromJson(json);
  }
}
