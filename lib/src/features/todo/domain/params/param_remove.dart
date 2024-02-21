import 'package:equatable/equatable.dart';

class ParamRemove extends Equatable {
  final int id;
  const ParamRemove({required this.id});
  @override
  List<Object?> get props => [id];
}
