class ActivityModel {
  int? activity_id;
  String? activity_name;
  String? date;

  ActivityModel(this.activity_id, this.activity_name, this.date);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'activity_id': activity_id,
      'activity_name': activity_name,
      'date': date
    };
    return map;
  }

  ActivityModel.fromMap(Map<String, dynamic> map) {
    activity_id = map['user_id'];
    activity_name = map['user_name'];
    date = map['email'];
  }
}
