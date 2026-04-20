class PatientModel {
  final String? uid;
  final String? name;
  final String? age;
  final String? gender;
  final String? image;
  final String? email;
  final String? phone;
  final String? city;
  final String? bio;

  PatientModel({
    this.name,
    this.email,
    this.uid,
    this.image,
    this.age,
    this.gender,
    this.phone,
    this.city,
    this.bio,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      image: json['image'],
      age: json['age'],
      gender: json['gender'],
      phone: json['phone'],
      city: json['city'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'image': image,
      'age': age,
      'gender': gender,
      'phone': phone,
      'city': city,
      'bio': bio,
    };
  }
}
