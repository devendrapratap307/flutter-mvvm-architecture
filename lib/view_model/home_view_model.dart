import 'package:flutter/material.dart';
import 'package:invoice/data/response/api_response.dart';
import 'package:invoice/model/joke_model.dart';
import 'package:invoice/model/population_model.dart';
import 'package:invoice/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<PopulationModel> populationData = ApiResponse.loading();
  ApiResponse<JokeModel> jokesData = ApiResponse.loading();

  setPopulationData(ApiResponse<PopulationModel> res) {
    print(res);
    populationData = res;
    notifyListeners();
  }

  setJoke(ApiResponse<JokeModel> res) {
    print(res);
    jokesData = res;
    notifyListeners();
  }

  Future<void> fetchPopulationList() async{
    setPopulationData(ApiResponse.loading());
    _myRepo.fetchPopulationData().then((value) {
      setPopulationData(ApiResponse.completed(value));
      print(value.data?.length);

      print("----------");
    }).onError((error, stackTrace) {
      setPopulationData(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchJokeData() async{
    setJoke(ApiResponse.loading());
    _myRepo.fetchJoke().then((value) {
      setJoke(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setJoke(ApiResponse.error(error.toString()));
    });
  }
}