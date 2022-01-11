class Cars {
  int? number;
  String? date;
  String? state;

  Cars({this.number, this.date, this.state});

  Cars.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    date = json['date'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['date'] = date;
    data['state'] = state;
    return data;
  }
}
