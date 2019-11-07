class NRC {
  String code;
  List<String> Name;

  NRC({this.code, this.Name});

  NRC.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    Name = json['Name'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['Name'] = this.Name;
    return data;
  }
}
