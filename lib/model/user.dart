class User{
  String id,firstName,lastName,email,password,confirmPassword,gender,dob,notification_token;
  int timeStamp;

//<editor-fold desc="Data Methods">
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.gender,
    required this.dob,
    required this.notification_token,
    required this.timeStamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          email == other.email &&
          password == other.password &&
          confirmPassword == other.confirmPassword &&
          gender == other.gender &&
          dob == other.dob &&
          notification_token == other.notification_token &&
          timeStamp == other.timeStamp);

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      confirmPassword.hashCode ^
      gender.hashCode ^
      dob.hashCode ^
      notification_token.hashCode ^
      timeStamp.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' id: $id,' +
        ' firstName: $firstName,' +
        ' lastName: $lastName,' +
        ' email: $email,' +
        ' password: $password,' +
        ' confirmPassword: $confirmPassword,' +
        ' gender: $gender,' +
        ' dob: $dob,' +
        ' notification_token: $notification_token,' +
        ' timeStamp: $timeStamp,' +
        '}';
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    String? gender,
    String? dob,
    String? notification_token,
    int? timeStamp,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      notification_token: notification_token ?? this.notification_token,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'password': this.password,
      'confirmPassword': this.confirmPassword,
      'gender': this.gender,
      'dob': this.dob,
      'notification_token': this.notification_token,
      'timeStamp': this.timeStamp,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      gender: map['gender'] as String,
      dob: map['dob'] as String,
      notification_token: map['notification_token'] as String,
      timeStamp: map['timeStamp'] as int,
    );
  }

//</editor-fold>
}