class IamSrkTweet {
  final String date;
  final String id;
  final String rawContent;
  final String quotedTweet;
  final String topic;
  final String sentiment;

  IamSrkTweet({
    required this.date,
    required this.id,
    required this.rawContent,
    required this.quotedTweet,
    required this.topic,
    required this.sentiment,
  });

    factory IamSrkTweet.fromJson(Map<String, dynamic> json) {
    return IamSrkTweet(
      date: json['date'],
      id: json['id'],
      rawContent: json['rawContent'] ?? '-',
      quotedTweet: json['quotedTweet'] ?? '-',
      topic: json['topic'] ?? '-',
      sentiment: json['sentiment'] ?? '-',
    );
  }

  factory IamSrkTweet.fromMap(Map<String, dynamic> map) {
    return IamSrkTweet(
      date: map['date'] ?? '',
      id: map['id'] ?? '',
      rawContent: map['rawContent'] ?? '',
      quotedTweet: map['quotedTweet'] ?? '',
      topic: map['topic'] ?? '',
      sentiment: map['sentiment'] ?? '',
    );
  }
}
