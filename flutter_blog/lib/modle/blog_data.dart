class BlogData {
  BlogData(
      {this.coverImagePath = '',
      this.id = "",
      this.titleTxt = '',
      this.introductionTxt = "",
      this.time = "",
      this.author = "",
      this.label = "",
      this.typesOf = "",
      this.isEncrypt = false});

  //封面
  String coverImagePath;

  //BlogId
  String id;

  //标题
  String titleTxt;

  //简介
  String introductionTxt;

  //时间
  String time;

  //作者
  String author;

  //标签
  String label;

  //分类
  String typesOf;

  //是否加密
  bool isEncrypt;

  static List<BlogData> hotelList = <BlogData>[
    BlogData(),
  ];
}
