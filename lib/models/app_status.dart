class AppStatus {
  AppStatus (this.lastResetWeek);

  AppStatus.fromObject(dynamic o) {
    _id = o['id'];
    lastResetWeek = o['resetWeek'];
  }

  int lastResetWeek;
  int _id;
  int get id => _id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': _id,
      'resetWeek': lastResetWeek
    };
  }
}
