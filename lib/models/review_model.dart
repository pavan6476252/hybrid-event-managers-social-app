
class Review {
  final String id; // Unique review identifier
  final String reviewerId; // ID of the user who wrote the review
  final String reviewedUserId; // ID of the user being reviewed
  double rating; // Review rating (e.g., 1-5 stars)
  String content; // Review text content
  DateTime createdAt; // Date when the review was written

  Review({
    required this.id,
    required this.reviewerId,
    required this.reviewedUserId,
    required this.rating,
    required this.content,
    required this.createdAt,
  });
}
