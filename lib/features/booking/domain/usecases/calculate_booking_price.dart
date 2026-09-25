class BookingPriceResult {
  final double subtotal;
  final double discount;
  final double additionalFees;
  final double total;

  BookingPriceResult({
    required this.subtotal,
    required this.discount,
    required this.additionalFees,
    required this.total,
  });
}

class CalculateBookingPrice {
  /// Menghitung harga booking berdasarkan durasi (dalam hari)
  /// 
  /// Aturan Diskon:
  /// - Jika durasi >= 3 hari, mendapat diskon 10% dari subtotal
  BookingPriceResult call({
    required int durationDays,
    required double pricePerDay,
    double additionalFees = 0,
  }) {
    if (durationDays <= 0) {
      throw ArgumentError('Duration must be at least 1 day');
    }

    double subtotal = durationDays * pricePerDay;
    double discount = 0;

    // Diskon 10% jika sewa 3 hari atau lebih
    if (durationDays >= 3) {
      discount = subtotal * 0.10;
    }

    double total = subtotal - discount + additionalFees;

    return BookingPriceResult(
      subtotal: subtotal,
      discount: discount,
      additionalFees: additionalFees,
      total: total,
    );
  }
}
