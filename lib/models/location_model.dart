class Country {
  final String? countryId;
  final String? country;

  Country({
    this.countryId,
    this.country,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["country_id"],
        country: json["country"],
      );
}

class States {
  final String? stateId;
  final String? state;

  States({
    this.stateId,
    this.state,
  });

  factory States.fromJson(Map<String, dynamic> json) => States(
        stateId: json["state_id"],
        state: json["state"],
      );
}

class City {
  final String? cityId;
  final String? city;

  City({
    this.cityId,
    this.city,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        city: json["city"],
      );
}
