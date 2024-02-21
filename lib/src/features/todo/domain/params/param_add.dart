import 'package:equatable/equatable.dart';

class ParamAdd extends Equatable {
  final String title;
  const ParamAdd({required this.title});
  @override
  List<Object?> get props => [title];
}
