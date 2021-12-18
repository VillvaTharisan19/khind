class Autogenerated {
  int id;
  int userId;
  int categoryId;
  String coverImg;
  String thumbnail;
  Null pdfFile;
  String title;
  int viewCount;
  Null description;
  String updatedAt;
  String createdAt;
  String publishedAt;
  Null publishStart;
  Null publishEnd;
  int status;
  int publishStatus;
  int commentsCount;
  List<Tags> tags;
  Null category;

  Autogenerated(
      {this.id,
      this.userId,
      this.categoryId,
      this.coverImg,
      this.thumbnail,
      this.pdfFile,
      this.title,
      this.viewCount,
      this.description,
      this.updatedAt,
      this.createdAt,
      this.publishedAt,
      this.publishStart,
      this.publishEnd,
      this.status,
      this.publishStatus,
      this.commentsCount,
      this.tags,
      this.category});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    coverImg = json['cover_img'];
    thumbnail = json['thumbnail'];
    pdfFile = json['pdf_file'];
    title = json['title'];
    viewCount = json['view_count'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    publishedAt = json['published_at'];
    publishStart = json['publish_start'];
    publishEnd = json['publish_end'];
    status = json['status'];
    publishStatus = json['publish_status'];
    commentsCount = json['comments_count'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['cover_img'] = this.coverImg;
    data['thumbnail'] = this.thumbnail;
    data['pdf_file'] = this.pdfFile;
    data['title'] = this.title;
    data['view_count'] = this.viewCount;
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['published_at'] = this.publishedAt;
    data['publish_start'] = this.publishStart;
    data['publish_end'] = this.publishEnd;
    data['status'] = this.status;
    data['publish_status'] = this.publishStatus;
    data['comments_count'] = this.commentsCount;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    return data;
  }
}

class Tags {
  int id;
  String createdAt;
  String updatedAt;
  String name;
  Pivot pivot;

  Tags({this.id, this.createdAt, this.updatedAt, this.name, this.pivot});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int postId;
  int tagId;

  Pivot({this.postId, this.tagId});

  Pivot.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    tagId = json['tag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['tag_id'] = this.tagId;
    return data;
  }
}
