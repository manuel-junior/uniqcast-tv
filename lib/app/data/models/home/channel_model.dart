import '../../../bindings/initial_bindings.dart';

class Channel {
  Channel({
    this.name,
    this.url,
    required this.lang,
    required this.template,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  String? name;
  String? url;
  String lang;
  String template;
  int id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Channel.fromJson(Map<dynamic, dynamic> json) => Channel(
        name: json["name"],
        url: json["url"],
        lang: json["lang"],
        template: json["template"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "lang": lang,
        "template": template,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  getLogoURL() {
    return logoURL + "$id.png";
  }
}
