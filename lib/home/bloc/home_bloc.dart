
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/bloc/bloc.dart';
import '../model/catbreeds.dart';
import '../repository/home_use_case.dart';


@injectable
class HomeBloc with Bloc {

  final HomeUseCase _homeUseCase;

  HomeBloc(this._homeUseCase);

  final _isLoadingSubject = BehaviorSubject<bool>();
  Function(bool) get isLoadingSink => _isLoadingSubject.sink.add;
  Stream<bool> get isLoadingStream => _isLoadingSubject.stream;

  final _typeErrorSubject = BehaviorSubject<String>();
  Function(String) get typeErrorSink => _typeErrorSubject.sink.add;
  Stream<String> get typeErrorStream => _typeErrorSubject.stream;
  String? get typeError => _typeErrorSubject.value;

  final _listCharactersSubject = BehaviorSubject<List<CatbreedsModel>>();
  Function(List<CatbreedsModel>) get listCharactersSink => _listCharactersSubject.sink.add;
  Stream<List<CatbreedsModel>> get listCharactersStream => _listCharactersSubject.stream;
  List<CatbreedsModel>? get listCharacters => _listCharactersSubject.value;

  final _listSearchSubject = BehaviorSubject<List<CatbreedsModel>>();
  Function(List<CatbreedsModel>) get listSearchSink => _listSearchSubject.sink.add;
  Stream<List<CatbreedsModel>> get listSearchStream => _listSearchSubject.stream;
  List<CatbreedsModel>? get listSearch => _listSearchSubject.value;

  @override
  void dispose() {
    _isLoadingSubject.close();
    _listCharactersSubject.close();
    _typeErrorSubject.close();
    _listSearchSubject.close();
  }

  Future<void> getCatbreeds() async {
    _homeUseCase.getCatbreeds().then((value) {
        listCharactersSink(value);
        listSearchSink(value);
    }).catchError((onError) {
        if (onError.errorCode == 'noInternet') {
          typeErrorSink("noInternet");
        } else {
          typeErrorSink("generic");
        }
    }).whenComplete(() => isLoadingSink(false));
  }

  void filterSearchResults(String query) {
    List<CatbreedsModel> list = listCharacters!
        .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    listSearchSink(list);
  }

  void cleanSearch(){
    listSearchSink(listCharacters!);
  }

}
