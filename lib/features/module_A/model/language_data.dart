class LanguageData {
  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    print("XXXXX1UUUUUU");
    return <LanguageData>[
      LanguageData("🇺🇸", "English", 'en'),
      LanguageData("tc", "中文", "tc"),
    ];
  }
}
