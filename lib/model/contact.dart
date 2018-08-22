class Contact {
  final String firstName, lastName, email, picture;

  Contact({this.firstName, this.lastName, this.email, this.picture });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
      picture: json['picture']['medium'],
    );
  }
}