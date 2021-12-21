class Language {
  /// the country code (IT,AF..)
  String? code;

  /// the locale (en, es, da)
  String? locale;

  /// image url
  String? imageurl;

  /// the full name of language (English, Danish..)
  String? language;

  /// enable or not
  bool? isEnable;

  /// map of keys used based on industry type (service worker, route etc)
  Map<String, String>? dictionary;

  Language({this.code, this.locale, this.imageurl, this.language, this.dictionary,this.isEnable});
}