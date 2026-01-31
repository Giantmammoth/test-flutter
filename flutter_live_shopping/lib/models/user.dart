import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String email;
  final String name;
  final String? avatar;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
    required this.createdAt,
  }) {
    _validate();
  }

  void _validate() {
    if (id.isEmpty) {
      throw ArgumentError('User id cannot be empty');
    }
    if (email.isEmpty || !email.contains('@')) {
      throw ArgumentError('User email must be valid');
    }
    if (name.isEmpty) {
      throw ArgumentError('User name cannot be empty');
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Factory pour créer un User depuis les données de test (mock-api-data.json)
  /// Prend un Map correspondant à un objet user du JSON
  factory User.fromTestData(Map<String, dynamic> json) {
    return User.fromJson(json);
  }
}
