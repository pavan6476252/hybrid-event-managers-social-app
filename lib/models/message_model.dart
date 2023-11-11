
class Message {
  final String id; // Unique message identifier
  final String senderId; // ID of the message sender
  final String recipientId; // ID of the message recipient
  String content; // Message content
  DateTime createdAt; // Date when the message was sent

  Message({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.createdAt,
  });
}
