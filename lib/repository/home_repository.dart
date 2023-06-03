import 'package:invoice/data/network/NetworkApiService.dart';
import 'package:invoice/model/joke_model.dart';
import 'package:invoice/model/population_model.dart';
import 'package:invoice/res/app_urls.dart';

import '../data/network/BaseApiServices.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<PopulationModel> fetchPopulationData() async {
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.populationEndPoint);
      return response = PopulationModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<JokeModel> fetchJoke() async {
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.jokeEndPoint);
      return response = JokeModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}