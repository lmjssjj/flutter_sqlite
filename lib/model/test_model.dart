class Test {
  /*id INTEGER PRIMARY KEY, name TEXT, value INTEGER, numb REAL*/
  int _id;
  String _name;
  int _value;
  double _numb;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  double get numb => _numb;

  set numb(double value) {
    _numb = value;
  }

  int get value => _value;

  set value(int value) {
    _value = value;
  }

  set name(String value) {
    _name = value;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["value"] = _value;
    map["numb"] = _numb;
    return map;
  }
}
