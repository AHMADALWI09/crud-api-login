class Product {
  int id; // product unique identifier
  String title; // product title
  String description;
  int price; // product price in cents
  double discountPercentage; // product discount percentage
  double rating; // product average rating
  int stock; // product stock quantity
  String brand; // product brand name
  String category; // product category
  String thumbnail; // product thumbnail image url
  String images; // product image urls list

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });
  factory Product.fromMap(Map<String, dynamic> data) => Product(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
      discountPercentage: data['discountPercentage'],
      rating: data['rating'],
      stock: data['stock'],
      brand: data['brand'],
      category: data['category'],
      thumbnail: data['thumbnail'],
      images: data['images']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "images": images
      };
}
