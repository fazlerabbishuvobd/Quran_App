import 'package:equatable/equatable.dart';
abstract class CubitState extends Equatable{
  const CubitState();
}

class CubitStateInit extends CubitState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CubitStateLoading extends CubitState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CubitStateDataLoaded extends CubitState{
  final List<dynamic> suraList;
  const CubitStateDataLoaded({required this.suraList});
  @override
  // TODO: implement props
  List<Object?> get props => [suraList];
}

class CubitStateError extends CubitState{
  final String message;
  const CubitStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}