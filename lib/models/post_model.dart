
class Post {
  final String postId;
  final String userId;
  final String content;
  final List<double> geoPoint;
  final List<String> imageUrls;
  final DateTime timestamp;
  final int likes;

  Post({
    required this.postId,
    required this.userId,
    required this.content,
    required this.geoPoint,
    required this.imageUrls,
    required this.timestamp,
    this.likes = 0,
  });
}