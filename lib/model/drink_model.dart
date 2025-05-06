class Drink {
  final String image;
  final String drinkName;
  final String shopName;
  final String caskNumber;
  final String ageStatement;
  final String drinkType;
  final String region;

  Drink({
    required this.image,
    required this.drinkName,
    required this.shopName,
    required this.caskNumber,
    required this.ageStatement,
    required this.drinkType,
    required this.region,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      image: json['image'],
      drinkName: json['drink_name'],
      shopName: json['shop_name'],
      caskNumber: json['cask_number'],
      ageStatement: json['age_statement'],
      drinkType: json['drink_type'],
      region: json['region'],
    );
  }
}
