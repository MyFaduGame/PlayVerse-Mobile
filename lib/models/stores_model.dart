class Products {
  final String? productId;
  final String? name;
  final String? description;
  final String? price;
  final bool? fromGems;
  final List<String>? images;
  final String? brand;
  final String? category;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? categoryName;
  final String? image;

  Products(
      {this.productId,
      this.name,
      this.description,
      this.price,
      this.fromGems,
      this.images,
      this.brand,
      this.category,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.categoryName,
      this.image});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
      productId: json["product_id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      fromGems: json["from_gems"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      brand: json["brand"],
      category: json["category"],
      isActive: json["is_active"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      categoryName: json["category_name"],
      image: json["image"]);
}

class Cart {
  final String? productId;
  final String? name;
  final String? brand;
  final double? price;
  final String? images;
  final int? productCount;
  final bool? soldOut;

  Cart({
    this.productId,
    this.name,
    this.brand,
    this.price,
    this.images,
    this.productCount,
    this.soldOut,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productId: json["product_id"],
        name: json["name"],
        brand: json["brand"],
        price: json["price"],
        images: json["images"],
        productCount: json["product_count"],
        soldOut: json["sold_out"],
      );
}
