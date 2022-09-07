//模擬網絡請求數據
class HttpUtils {
  Future<SplashModel> getSplash() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return SplashModel(
        title: 'Flutter 常用工具類庫',
        content: 'Flutter 常用工具類庫',
        url: 'https://www.jianshu.com/p/425a7ff9d66e',
        imgUrl:
            'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_common_utils_a.png',
      );
    });
  }

  /// 該地址可能無法下載，請自行更換可測試apk地址。
  Future<VersionModel> getVersion() async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return VersionModel(
        title: '有新版本v0.2.6，快去更新吧！',
        content: '1.基礎庫升級 | 2.修復OPPO R15詳情頁問題 | 3.一些優化~',
        url:
            'https://raw.githubusercontent.com/Sky24n/Doc/master/apks/flutter_wanandroid.apk',
        version: '0.2.6',
      );
    });
  }

  Future<ComModel> getRecItem() async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return ComModel(
          version: "version",
          title: "title",
          content: "content",
          extra: "extra",
          url: "url",
          imgUrl: "imgUrl",
          author: "author",
          updatedAt: "updatedAt",
          typeId: 1,
          titleId: "titleId");
    });
  }

  Future<List<ComModel>> getRecList() async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return [];
    });
  }
}

class LanguageModel {
  String titleId;
  String languageCode;
  String countryCode;
  bool isSelected;

  LanguageModel(this.titleId, this.languageCode, this.countryCode,
      {this.isSelected = false});

  LanguageModel.fromJson(Map<dynamic, dynamic> json)
      : titleId = json['titleId'],
        languageCode = json['languageCode'],
        countryCode = json['countryCode'],
        isSelected = json['isSelected'];

  Map<String, dynamic> toJson() => {
        'titleId': titleId,
        'languageCode': languageCode,
        'countryCode': countryCode,
        'isSelected': isSelected,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"titleId\":\"$titleId\"");
    sb.write(",\"languageCode\":\"$languageCode\"");
    sb.write(",\"countryCode\":\"$countryCode\"");
    sb.write('}');
    return sb.toString();
  }
}

class SplashModel {
  String title;
  String content;
  String url;
  String imgUrl;

  SplashModel(
      {required this.title,
      required this.content,
      required this.url,
      required this.imgUrl});

  SplashModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        url = json['url'],
        imgUrl = json['imgUrl'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'url': url,
        'imgUrl': imgUrl,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imgUrl\":\"$imgUrl\"");
    sb.write('}');
    return sb.toString();
  }
}

class VersionModel {
  String title;
  String content;
  String url;
  String version;

  VersionModel(
      {required this.title,
      required this.content,
      required this.url,
      required this.version});

  VersionModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        url = json['url'],
        version = json['version'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'url': url,
        'version': version,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"version\":\"$version\"");
    sb.write('}');
    return sb.toString();
  }
}

class ComModel {
  String version;
  String title;
  String content;
  String extra;
  String url;
  String imgUrl;
  String author;
  String updatedAt;

  int typeId;
  String titleId;

  ComModel({
    required this.version,
    required this.title,
    required this.content,
    required this.extra,
    required this.url,
    required this.imgUrl,
    required this.author,
    required this.updatedAt,
    required this.typeId,
    required this.titleId,
  });

  ComModel.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        title = json['title'],
        titleId = json['titleId'],
        typeId = json['typeId'],
        content = json['content'],
        extra = json['extra'],
        url = json['url'],
        imgUrl = json['imgUrl'],
        author = json['author'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'version': version,
        'title': title,
        'content': content,
        'extra': extra,
        'url': url,
        'imgUrl': imgUrl,
        'author': author,
        'updatedAt': updatedAt,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"version\":\"$version\"");
    sb.write(",\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imgUrl\":\"$imgUrl\"");
    sb.write(",\"author\":\"$author\"");
    sb.write(",\"updatedAt\":\"$updatedAt\"");
    sb.write('}');
    return sb.toString();
  }
}
