class UserModel {
  String? id;
  String? name;
  String? mobileNumber;
  String? emailAddress;
  String? gender;
  String? profilePicture;

  UserModel({
    this.id,
    this.name,
    this.mobileNumber,
    this.emailAddress,
    this.gender,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      mobileNumber: json['mobile_number'],
      emailAddress: json['email_address'],
      gender: json['gender'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile_number': mobileNumber,
      'email_address': emailAddress,
      'gender': gender,
      'profile_picture': profilePicture,
    };
  }
}
