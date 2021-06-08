import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.nameDevice,
    this.eventDate,
    this.eventDescription,
  });

  String nameDevice;
  DateTime eventDate;
  String eventDescription;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nameDevice: json["nameDevice"],
    eventDate: DateTime.parse(json["eventDate"]),
    eventDescription: json["eventDescription"],
  );

  Map<String, dynamic> toJson() => {
    "nameDevice": nameDevice,
    "eventDate": eventDate.toIso8601String(),
    "eventDescription": eventDescription,
  };
}