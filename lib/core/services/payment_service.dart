class PaymentService {
  /// Mock Midtrans Payment API
  /// Returns [true] if payment is successful, [false] otherwise.
  Future<bool> processPayment({
    required String bookingId,
    required double amount,
    required String paymentMethod,
  }) async {
    // Simulate network delay for payment gateway
    await Future.delayed(const Duration(seconds: 2));

    // For mock purposes, let's say if amount > 0, it always succeeds
    if (amount <= 0) {
      return false;
    }
    
    return true;
  }
}
