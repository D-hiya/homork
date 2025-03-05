class Property {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final int bedrooms;
  final String location;
  final double latitude;
  final double longitude;

  Property({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.bedrooms,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'bedrooms': bedrooms,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      bedrooms: map['bedrooms'],
      location: map['location'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
