class NewsTopic {
  final String topic;

  NewsTopic({required this.topic});

  factory NewsTopic.fromJson(Map<String, dynamic> json) {
    return NewsTopic(
      topic: json['topic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
    };
  }
}