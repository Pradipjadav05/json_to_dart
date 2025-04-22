class Temp {
  late final int? id;
  String? name;
  late final String? username;
  late final String? email;
  late final Address? address;
  late final String? phone;
  late final String? website;
  late final Company? company;

  Temp({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company
  });

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        website: json["website"],
        company: json["company"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
      "address": address,
      "phone": phone,
      "website": website,
      "company": company
    };
  }
}

class Address {
  late final String? street;
  late final String? suite;
  late final String? city;
  late final String? zipcode;
  late final Geo? geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: json["geo"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "street": street,
      "suite": suite,
      "city": city,
      "zipcode": zipcode,
      "geo": geo
    };
  }
}

class Geo {
  late final String? lat;
  late final String? lng;

  Geo({
    this.lat,
    this.lng
  });

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
        lat: json["lat"],
        lng: json["lng"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng
    };
  }
}

class Company {
  late final String? name;
  late final String? catchPhrase;
  late final List<dynamic>? bs;

  Company({
    this.name,
    this.catchPhrase,
    this.bs
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "catchPhrase": catchPhrase,
      "bs": bs
    };
  }
}

