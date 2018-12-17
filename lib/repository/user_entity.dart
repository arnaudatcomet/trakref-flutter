class UserEntity {
  String _token = "";
  int _userID = 0;

  UserEntity(this._userID, this._token);

  UserEntity.map(dynamic obj) {
    this._token = obj['Token'];
    this._userID = obj['UserID'];
  }

  String get token => _token;
  int get userID => _userID;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['Token'] = _token;
    map['UserID'] = _userID;
    return map;
  }

  @override
  String toString() {
    return 'UserEntity{id: $userID, token : $token}';
  }
}