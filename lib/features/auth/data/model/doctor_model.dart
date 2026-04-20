class DoctorModel {
  final String? uid;
  final String? name;
  final String? image;
  final String? specialization;
  final String? rating;
  final String? email;
  final String? phone1;
  final String? phone2;
  final String? address;
  final String? openHours;
  final String? closeHours;
  final String? bio;

  DoctorModel({
    this.name,
    this.email,
    this.uid,
    this.image,
    this.specialization,
    this.phone1,
    this.phone2,
    this.address,
    this.bio,
    this.rating,
    this.openHours,
    this.closeHours,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      image: json['image'],
      specialization: json['specialization'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      address: json['address'],
      bio: json['bio'],
      rating: json['rating'],
      openHours: json['openHours'],
      closeHours: json['closeHours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'image': image,
      'specialization': specialization,
      'phone1': phone1,
      'phone2': phone2,
      'address': address,
      'bio': bio,
      'rating': rating,
      'openHours': openHours,
      'closeHours': closeHours,
    };
  }
}
