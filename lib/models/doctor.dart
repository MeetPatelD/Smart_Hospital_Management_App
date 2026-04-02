class Doctor {
  String name;
  String specialization;
  String email;

  Doctor({required this.name, required this.specialization, this.email = ''});

  Map<String, dynamic> toJson() {
    return {'name': name, 'specialization': specialization, 'email': email};
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      specialization: json['specialization'],
      email: json['email'] ?? '',
    );
  }
}
