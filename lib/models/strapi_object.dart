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
    id = int.tryParse(data['id'] ?? "0") ?? 0;
    // TODO: change the below value into a datetime object
    createdAt = DateTime.parse(data['createdAt']);
    updatedAt = DateTime.parse(data['updatedAt']);
  }
}
