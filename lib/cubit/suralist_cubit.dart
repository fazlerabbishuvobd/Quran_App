import 'package:quran_app/cubit/suralist_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/api_services.dart';

class SuraListCubit extends Cubit<CubitState>{
  List<dynamic> suraList=[];
  ApiServices apiServices;
  SuraListCubit({required this.apiServices}):super(CubitStateInit());

  void getSuraList() async{
    try{
      emit(CubitStateLoading());
      suraList = await apiServices.getSuraLists();
      emit(CubitStateDataLoaded(suraList: suraList));
    }catch(e){
      emit(CubitStateError(message: e.toString()));
    }
  }

}