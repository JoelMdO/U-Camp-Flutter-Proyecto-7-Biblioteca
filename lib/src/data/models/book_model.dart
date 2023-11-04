///The [Book] model has an structure according to the JSON scheme received from
///Google Books though an API key, its purpose is only for mapping the values
///and populate the [ResultSearchBook] page, for database interaction please refer
///to the [Library] model dart file, the class book has a list [VolumeItem] as the
///type of the JSON schema is retrieving inside of [items] strings and one list
///the main string required is [selfLink] and the list is [VolumeInfo] the volumeInfo
///is to access the [title], [author], regading the [cover] : inside of VolumeInfo list another
///list with the thumbnail information

class Book {
  String? kind;
  int? totalItems;
  List<VolumeItem>? items;

  Book({
    this.kind,
    this.totalItems,
    this.items,
  });

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "totalItems": totalItems,
        "items": items?.map((item) => item.toJson()).toList(),
      };

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      kind: json['kind'] ?? '',
      totalItems: json['totalItems'] ?? 0,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => VolumeItem.fromJson(item))
              .toList() ??
          <VolumeItem>[],
    );
  }
}

class VolumeItem {
  String kind;
  String id;
  String etag;
  String selfLink;
  VolumeInfo volumeInfo;

  VolumeItem({
    required this.kind,
    required this.id,
    required this.etag,
    required this.selfLink,
    required this.volumeInfo,
  });

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "id": id,
        "etag": etag,
        "selfLink": selfLink,
        "volumeInfo": volumeInfo.toJson(),
      };

  factory VolumeItem.fromJson(Map<String, dynamic> json) {
    return VolumeItem(
      kind: json['kind'] ?? '',
      id: json['id'] ?? '',
      etag: json['etag'] ?? '',
      selfLink: json['selfLink'] ?? '',
      volumeInfo: VolumeInfo.fromJson(json['volumeInfo'] ?? {}),
    );
  }
}

class VolumeInfo {
  String title;
  String? subtitle;
  List<String>? authors;
  String? description;
  List<dynamic>? categories;
  ImageLinks imageLinks;
  String? previewLink;
  String? infoLink;

  VolumeInfo({
    required this.title,
    this.subtitle,
    this.authors,
    this.description,
    this.categories,
    required this.imageLinks,
    this.previewLink,
    this.infoLink,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "authors": authors?.map((x) => x),
        "description": description,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "imageLinks": imageLinks.toJson(),
        "previewLink": previewLink,
        "infoLink": infoLink,
      };

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title'] ?? '',
      subtitle: json["subtitle"] ?? '',
      authors: json["authors"] != null
          ? List<String>.from(json["authors"].map((x) => x))
          : null,
      description: json["description"] ?? '',
      categories: json["categories"] == null
          ? []
          : List<String>.from(json["categories"]!.map((x) => x)),
      imageLinks: ImageLinks.fromJson(json["imageLinks"] ?? {}),
      previewLink: json["previewLink"] ?? '',
      infoLink: json["infoLink"] ?? '',
    );
  }
}

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json["smallThumbnail"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail,
        "thumbnail": thumbnail,
      };
}
