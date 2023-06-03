class PopulationModel {
  List<Data>? data;

  PopulationModel({this.data});

  PopulationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? iDNation;
  String? nation;
  int? iDYear;
  String? year;
  int? population;
  String? slugNation;

  Data(
      {this.iDNation,
        this.nation,
        this.iDYear,
        this.year,
        this.population,
        this.slugNation});

  Data.fromJson(Map<String, dynamic> json) {
    iDNation = json['ID Nation'];
    nation = json['Nation'];
    iDYear = json['ID Year'];
    year = json['Year'];
    population = json['Population'];
    slugNation = json['Slug Nation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID Nation'] = this.iDNation;
    data['Nation'] = this.nation;
    data['ID Year'] = this.iDYear;
    data['Year'] = this.year;
    data['Population'] = this.population;
    data['Slug Nation'] = this.slugNation;
    return data;
  }
}
