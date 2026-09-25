import '../../domain/entities/rental_unit.dart';

class RentalUnitModel extends RentalUnit {
  RentalUnitModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.pricePerHour,
    required super.pricePerDay,
    required super.ramGB,
    required super.gpu,
  });

  factory RentalUnitModel.fromJson(Map<String, dynamic> json) {
    return RentalUnitModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      ramGB: json['ramGB'],
      gpu: json['gpu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'pricePerHour': pricePerHour,
      'pricePerDay': pricePerDay,
      'ramGB': ramGB,
      'gpu': gpu,
    };
  }
}
