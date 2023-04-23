import 'dart:convert';

import 'package:admin/models/ElonMuskTweet.dart';
import 'package:admin/models/IamSrkTweet.dart';
import 'package:admin/models/NewsTopic.dart';
import 'package:admin/models/TweeterProfile.dart';
import 'package:admin/models/tweet.dart';
import 'package:admin/models/word.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class LocalDataRepository {
  static const PATH_NEWS_HEADLINES = 'news.csv';
  static const PATH_PROFILE_IAMSRK = 'tweet_profile.csv';
  static const PATH_PROFILE_ELONMUSK = 'elonmusk_tweeter_profile.csv';
  static const PATH_POST_A_IAMSRK = 'iamsrk_pa.csv';
  static const PATH_POST_A_ELONMUSK = 'elonmusk_pa.csv';

  static const PATH_NEWS_HEADLINES_JSON = 'news_topics_full.json';
  static const PATH_POST_A_ELONMUSK_JSON =
      'elonmusk-tweets-with-topics-sentiment.json';
  static const PATH_POST_A_IAMSRK_JSON =
      'iamsrk-tweets-with-topics-sentiment.json';
  static const PATH_PROFILE_IAMSRK_JSON = 'iamsrk_tweet_profile.json';
  static const PATH_PROFILE_ELONMUSK_JSON = 'elonmusk-profile.json';
  static const PATH_PA_ELONMUSK_JSON_CLASS =
      'elonmusk_topic_class_sentiment.json';
  static const PATH_PA_IAMSRK_JSON_CLASS = 'iamsrk_topic_class_sentiment.json';
  static const PATH_POST_T_ELONMUSK_JSON = 'elonmusk_topic_post_sentiment.json';
  static const PATH_POST_T_IAMSRK_JSON = 'iamsrk_topic_post_sentiment.json';

  late List<NewsTopic> _news;
  late List<ElonMuskTweet> _postsSrk;
  late List<ElonMuskTweet> _postElonmusk;
  late TweeterProfile _profileSrk;
  late TweeterProfile _profileElonmusk;
  late List<Tweet> _tweets;
  late List<Word> _topics;
  late List<Tweet> _tweetsElonmusk;
  late List<Word> _topicsElonMusk;
  late List<Tweet> _tweetsSrk;
  late List<Word> _topicsSrk;

  List<NewsTopic> get getNews => _news;
  List<ElonMuskTweet> get getPostSrk => _postsSrk;
  List<ElonMuskTweet> get getPostElonmusk => _postElonmusk;
  TweeterProfile get getProfileSrk => _profileSrk;
  TweeterProfile get getProfileElonmusk => _profileElonmusk;
  List<Tweet> get getTweets => _tweets;
  List<Word> get getTopics => _topics;

  List<Tweet> get getTweetsElonmusk => _tweetsElonmusk;
  List<Word> get getTopicsElonmusk => _topicsElonMusk;

  List<Tweet> get getTweetsSrk => _tweetsSrk;
  List<Word> get getTopicsSrk => _topicsSrk;

  static final LocalDataRepository instance =
      LocalDataRepository._getInstance();

  LocalDataRepository._getInstance();

  Future<void> loadData() async {
    await loadNewsJSON();
    await loadPostElonmusk();
    await loadPostIamSrk();
    await loadProfileElonMusk();
    await loadProfileIamSrk();
    await loadTweetsElonmusk();
    await loadTweetsSrk();
    await loadTopicsElonmusk();
    await loadTopicsSrk();
  }

  Future<List<NewsTopic>> loadNews() async {
    String data = await rootBundle.loadString(PATH_NEWS_HEADLINES);
    List<List<dynamic>> csvTable = CsvToListConverter().convert(data);
    print(csvTable[0].length.toString());
    List<NewsTopic> newsTopicList = csvTable.skip(1).map((row) {
      print(row);
      return NewsTopic(topic: row[0]
          // Add additional properties as needed
          );
    }).toList();

    return newsTopicList;
  }

  Future<List<NewsTopic>> loadNewsJSON() async {
    String data = await rootBundle.loadString(PATH_NEWS_HEADLINES_JSON);
    List<dynamic> jsonList = json.decode(data);

    List<NewsTopic> modelList = jsonList.map((item) {
      return NewsTopic.fromJson(item);
    }).toList();
    _news = modelList;
    return modelList;
  }

  Future<List<ElonMuskTweet>> loadPostElonmusk() async {
    String data = await rootBundle.loadString(PATH_POST_A_ELONMUSK_JSON);
    List<dynamic> jsonList = json.decode(data);
    List<ElonMuskTweet> modelList = jsonList.map((item) {
      return ElonMuskTweet.fromJson(item);
    }).toList();
    _postElonmusk = modelList;
    return modelList;
  }

  Future<List<ElonMuskTweet>> loadPostIamSrk() async {
    String data = await rootBundle.loadString(PATH_POST_A_IAMSRK_JSON);
    List<dynamic> jsonList = json.decode(data);
    List<ElonMuskTweet> modelList = jsonList.map((item) {
      return ElonMuskTweet.fromJson(item);
    }).toList();
    _postsSrk = modelList;
    return modelList;
  }

  Future<List<TweeterProfile>> loadProfileIamSrk() async {
    String data = await rootBundle.loadString(PATH_PROFILE_IAMSRK_JSON);
    List<dynamic> jsonList = json.decode(data);
    List<TweeterProfile> modelList = jsonList.map((item) {
      return TweeterProfile.fromJson(item);
    }).toList();
    _profileSrk = modelList[0];
    return modelList;
  }

  Future<List<TweeterProfile>> loadProfileElonMusk() async {
    String data = await rootBundle.loadString(PATH_PROFILE_ELONMUSK_JSON);
    List<dynamic> jsonList = json.decode(data);
    List<TweeterProfile> modelList = jsonList.map((item) {
      return TweeterProfile.fromJson(item);
    }).toList();
    _profileElonmusk = modelList[0];
    return modelList;
  }

  Future<List<Tweet>> loadTweets(String path) async {
    String data = await rootBundle.loadString(path);
    List<dynamic> jsonList = json.decode(data);
    List<Tweet> modelList = jsonList.map((item) {
      return Tweet.fromJson(item);
    }).toList();
    _tweets = modelList;
    return modelList;
  }

  Future<List<Word>> loadTopics(String path) async {
    String data = await rootBundle.loadString(path);
    List<dynamic> jsonList = json.decode(data);
    List<Word> modelList = jsonList.map((item) {
      return Word.fromJson(item);
    }).toList();
    _topics = modelList;
    return modelList;
  }

  Future<List<Tweet>> loadTweetsElonmusk() async {
    _tweetsElonmusk = await loadTweets(PATH_POST_T_ELONMUSK_JSON);
    // print(_tweetsElonmusk[0].toJson().toString());
    return _tweetsElonmusk;
  }

  Future<List<Tweet>> loadTweetsSrk() async {
    _tweetsSrk = await loadTweets(PATH_POST_T_IAMSRK_JSON);
    // print(_tweetsSrk[0].toJson().toString());
    return _tweetsSrk;
  }

  Future<List<Word>> loadTopicsElonmusk() async {
    _topicsElonMusk = await loadTopics(PATH_PA_ELONMUSK_JSON_CLASS);
    // print(_topicsElonMusk[0].toJson().toString());
    return _topicsElonMusk;
  }

  Future<List<Word>> loadTopicsSrk() async {
    _topicsSrk = await loadTopics(PATH_PA_IAMSRK_JSON_CLASS);
    // print(_topicsSrk[0].toJson().toString());
    return _topicsSrk;
  }
}
