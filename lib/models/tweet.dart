class Tweet {
  String? date;
  String? id;
  String? rawContent;
  String? retweetedTweet;
  String? quotedTweet;
  String? hashtags;
  String? replyCount;
  String? retweetCount;
  String? likeCount;
  String? quoteCount;
  String? viewCount;
  String? clean;
  List<String>? sentiment;
  List<String>? topic;
  String? names;

  Tweet({
    this.date,
    this.id,
    this.rawContent,
    this.retweetedTweet,
    this.quotedTweet,
    this.hashtags,
    this.replyCount,
    this.retweetCount,
    this.likeCount,
    this.quoteCount,
    this.viewCount,
    this.clean,
    this.sentiment,
    this.topic,
    this.names,
  });

  factory Tweet.fromJson(Map<String, dynamic> json) {
    print(json['sentiment']);
    return Tweet(
      date: json['date'] as String,
      id: json['id'] as String,
      rawContent: json['rawContent'] as String,
      retweetedTweet: json['retweetedTweet'] as String,
      quotedTweet: json['quotedTweet'] as String,
      hashtags: json['hashtags'] as String,
      replyCount: json['replyCount'] as String,
      retweetCount: json['retweetCount'] as String,
      likeCount: json['likeCount'] as String,
      quoteCount: json['quoteCount'] as String,
      viewCount: json['viewCount'] as String,
      clean: json['clean'] as String,
      sentiment: List<String>.from(json['sentiment'] as List<dynamic>),
      topic: List<String>.from(json['topic'] as List<dynamic>),
      names: json['names'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'id': id,
        'rawContent': rawContent,
        'retweetedTweet': retweetedTweet,
        'quotedTweet': quotedTweet,
        'hashtags': hashtags,
        'replyCount': replyCount,
        'retweetCount': retweetCount,
        'likeCount': likeCount,
        'quoteCount': quoteCount,
        'viewCount': viewCount,
        'clean': clean,
        'sentiment': sentiment,
        'topic': topic,
        'names': names,
      };
}
