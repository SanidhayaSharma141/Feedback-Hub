class StrapiObject {
  int id;
  late DateTime createdAt, updatedAt;
  StrapiObject({
    this.id = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
  }

  void load(Map<String, dynamic> data) {
    id = data['id'] ?? id;
    if (data['createdAt'] != null) {
      createdAt = DateTime.parse(data['createdAt']);
    }
    if (data['updatedAt'] != null) {
      updatedAt = DateTime.parse(data['updatedAt']);
    }
  }
}
