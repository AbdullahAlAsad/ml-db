import 'dart:convert';

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

  factory Tweet.fromJson(Map<String, dynamic> js) {
    String senJs = js['sentiment'];
    senJs = senJs.replaceAll("'","\"");
    String topJs = js['topic'];
    topJs = topJs.replaceAll("'","\"");
    return Tweet(
      date: js['date'] as String,
      id: js['id'] as String,
      rawContent: js['rawContent'] as String,
      retweetedTweet: js['retweetedTweet'] as String,
      quotedTweet: js['quotedTweet'] as String,
      hashtags: js['hashtags'] as String,
      replyCount: js['replyCount'] as String,
      retweetCount: js['retweetCount'] as String,
      likeCount: js['likeCount'] as String,
      quoteCount: js['quoteCount'] as String,
      viewCount: js['viewCount'] as String,
      clean: js['clean'] as String,
      sentiment: json.decode(senJs).cast<String>(),//List<String>.from(json['sentiment'] as List<dynamic>),
      topic: json.decode(topJs).cast<String>(),//List<String>.from(js['topic'] as List<dynamic>),
      names: js['names'] as String,
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
