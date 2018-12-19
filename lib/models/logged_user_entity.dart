class LoggedUser {
  String username = "";
  String password = "";

  User user;
  Token token;

  LoggedUser(this.user, this.token);

  factory LoggedUser.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return LoggedUser(parsedJson['user'], parsedJson['token']);
  }

  LoggedUser.empty() {
    User user = null;
    Token token = null;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "user : $user.toString(), token : $token.toString()";
  }
}

class User {
  int instanceID = 0;
  String username = "";
  String fullName = "";
  String phone = "";
  String email = "";
  String certificationType = "";
  String certificateNumber = "";
  String company = "";
  int preferredLeakDetectionMethodID = 0;
  String preferredLeakDetectionMethod = "";

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    int instanceID = parsedJson['InstanceID'];
    String username = parsedJson['Username'];
    String fullName = parsedJson['FullName'];
    String phone = parsedJson['Phone'];
    String email = parsedJson['Email'];
    String certificationType = parsedJson['CertificationType'];
    String certificateNumber = parsedJson['CertificateNumber'];
    String company = parsedJson['Company'];
    int preferredLeakDetectionMethodID = parsedJson['PreferredLeakDetectionMethodID'];
    String preferredLeakDetectionMethod = parsedJson['PreferredLeakDetectionMethod'];
    return User(
        instanceID,
        username,
        fullName,
        phone,
        email,
        certificationType,
        certificateNumber,
        company,
        preferredLeakDetectionMethodID,
        preferredLeakDetectionMethod);
  }

  User(this.instanceID, this.username, this.fullName, this.phone, this.email,
      this.certificationType, this.certificateNumber, this.company,
      this.preferredLeakDetectionMethodID, this.preferredLeakDetectionMethod);

  @override
  String toString() {
    // TODO: implement toString
    String instanceID = this.instanceID.toString();
    return "User {instanceID: $instanceID, username: $this.username}";
  }
}

class Token {
  String token = "";
  int userID = 0;

  factory Token.fromJson(Map<String, dynamic> parsedJson) {
    String token = parsedJson['Token'];
    int userID = parsedJson['UserID'];
    return Token(token, userID);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['Token'] = token;
    map['UserID'] = userID;
    return map;
  }

  Token(this.token, this.userID);

  @override
  String toString() {
    return "Token {token: $this.token, userID: $this.userID}";
  }
}