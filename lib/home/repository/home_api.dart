
import 'package:injectable/injectable.dart';

import '../../app/api_source.dart';
import '../model/catbreeds.dart';
import 'home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final ApiSource _apiSource;

  HomeRepositoryImpl(this._apiSource);

  @override
  Future<List<CatbreedsModel>> getCatbreeds() async {
    final Uri url = Uri.parse(_apiSource.baseUrl);
    var jsonResponse = await _apiSource.getService(url);
    var list = jsonResponse.map((job) => CatbreedsModel.fromJson(job)).toList();
    return list;
  }

}
