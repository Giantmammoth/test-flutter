import 'package:equatable/equatable.dart';

class AppRoute with EquatableMixin {
  const AppRoute(this.path, this.location, this.name);

  final String path;
  final String location;
  final String name;

  @override
  List<Object?> get props => [path, location, name];
}
