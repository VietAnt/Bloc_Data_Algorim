class UserLocation {
  final String city;
  final String state;
  final String country;
  final String postcode;
  final LocationStreet street;
  final LocationCoordinate coordinates;
  final LocationTimezone timezone;
  //!Contructor
  UserLocation({
    required this.city,
    required this.coordinates,
    required this.country,
    required this.postcode,
    required this.state,
    required this.street,
    required this.timezone,
  });

  factory UserLocation.fromMap(Map<String, dynamic> json) {
    final coordinates = LocationCoordinate.fromMap(json['coordinates']);
    final street = LocationStreet.fromMap(json['street']);
    final timezone = LocationTimezone.fromMap(json['timezone']);

    //-----------------//
    return UserLocation(
      city: json['city'],
      coordinates: coordinates,
      country: json['country'],
      //Some post code are string
      postcode: json['postcode'].toString(),
      state: json['state'],
      street: street,
      timezone: timezone,
    );
  }
}

class LocationStreet {
  final int number;
  final String name;

  //----------------//
  LocationStreet({
    required this.name,
    required this.number,
  });

  factory LocationStreet.fromMap(Map<String, dynamic> json) {
    return LocationStreet(
      name: json['name'],
      number: json['number'],
    );
  }
}

class LocationCoordinate {
  final String longitude;
  final String latitude;
  LocationCoordinate({
    required this.latitude,
    required this.longitude,
  });

  factory LocationCoordinate.fromMap(Map<String, dynamic> json) {
    return LocationCoordinate(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class LocationTimezone {
  final String offset;
  final String description;
  LocationTimezone({
    required this.description,
    required this.offset,
  });

  //factory
  factory LocationTimezone.fromMap(Map<String, dynamic> json) {
    return LocationTimezone(
      description: json['description'],
      offset: json['offset'],
    );
  }
}
