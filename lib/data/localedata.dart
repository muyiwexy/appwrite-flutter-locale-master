
class LocaleFields {
  static const String ip = "ip";
  static const String countrycode = "countryCode";
  static const String country = "country";
  static const String continentcode = "continentCode";
  static const String continent = "continent";
  static const String eu = "eu";
  static const String currency = "currency";
}
class LocaleData {
  String ip;
  String countryCode;
  String country;
  String continentCode;
  String continent;
  bool eu;
  String currency;
  LocaleData(
      {required this.ip,
      required this.countryCode,
      required this.country,
      required this.continentCode,
      required this.continent,
      required this.eu,
      required this.currency});
  LocaleData.fromJson(Map<String, dynamic> json)
      : this(
            ip: json[LocaleFields.ip],
            countryCode: json[LocaleFields.countrycode],
            country: json[LocaleFields.country],
            continentCode: json[LocaleFields.continentcode],
            continent: json[LocaleFields.continent],
            eu: json[LocaleFields.eu] == 1,
            currency: json[LocaleFields.currency]);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[LocaleFields.ip] = ip;
    data[LocaleFields.continent] = continent;
    data[LocaleFields.continentcode] = continentCode;
    data[LocaleFields.country] = country;
    data[LocaleFields.countrycode] = countryCode;
    data[LocaleFields.eu] = eu ? 1 : 0;
    data[LocaleFields.currency] = currency;
    return data;
  }
}
