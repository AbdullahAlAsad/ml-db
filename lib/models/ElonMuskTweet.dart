class ElonMuskTweet {
  final String date;
  final String id;
  final String rawContent;
  final String quotedTweet;
  final String topic;
  final String sentiment;

  ElonMuskTweet({
    required this.date,
    required this.id,
    required this.rawContent,
    required this.quotedTweet,
    required this.topic,
    required this.sentiment,
  });

  factory ElonMuskTweet.fromJson(Map<String, dynamic> json) {
    return ElonMuskTweet(
      date: json['date'],
      id: json['id'],
      rawContent: json['rawContent'] ?? '-',
      quotedTweet: json['quotedTweet'] ?? '-',
      topic: json['topic'] ?? '-',
      sentiment: json['sentiment'] ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'id': id,
      'rawContent': rawContent,
      'quotedTweet': quotedTweet,
      'topic': topic,
      'sentiment': sentiment,
    };
  }
}
