class MyClass {
  late final int? id;
  late final String? name;
  late final String? username;
  late final String? email;
  late final Address? address;
  late final String? phone;
  late final String? website;
  late final Company? company;

  MyClass({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company
  });

  factory MyClass.fromJson(Map<String, dynamic> json) {
    return MyClass(
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
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo
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
    required this.lat,
    required this.lng
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
  late final String? bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs
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

