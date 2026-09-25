class RentalUnit {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double pricePerHour;
  final double pricePerDay;
  final int ramGB;
  final String gpu;

  RentalUnit({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.ramGB,
    required this.gpu,
  });
}
