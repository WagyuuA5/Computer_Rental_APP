import 'package:flutter/material.dart';
import '../../domain/entities/booking.dart';

class BookingTimelineWidget extends StatelessWidget {
  final BookingStatus currentStatus;

  const BookingTimelineWidget({super.key, required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    if (currentStatus == BookingStatus.cancelled) {
      return const _CancelledTimeline();
    }

    final statuses = [
      BookingStatus.pending,
      BookingStatus.confirmed,
      BookingStatus.ongoing,
      BookingStatus.completed,
    ];

    final currentIndex = statuses.indexOf(currentStatus);

    return Row(
      children: List.generate(statuses.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Line connecting circles
          final isPast = (index ~/ 2) < currentIndex;
          return Expanded(
            child: Container(
              height: 4,
              color: isPast ? Colors.blue : Colors.grey[300],
            ),
          );
        } else {
          // Circle with status
          final stepIndex = index ~/ 2;
          final isCompleted = stepIndex <= currentIndex;
          final isActive = stepIndex == currentIndex;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.blue : (isCompleted ? Colors.blue[300] : Colors.grey[300]),
                  border: Border.all(
                    color: isCompleted ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 4),
              Text(
                statuses[stepIndex].name,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isCompleted ? Colors.black : Colors.grey,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class _CancelledTimeline extends StatelessWidget {
  const _CancelledTimeline();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: const Icon(Icons.close, size: 14, color: Colors.white),
        ),
        const SizedBox(height: 4),
        const Text(
          'Cancelled',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
