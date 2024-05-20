import 'package:equatable/equatable.dart';

class OptionData extends Equatable {

  const OptionData({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];

}