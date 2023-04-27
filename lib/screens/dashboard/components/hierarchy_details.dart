import 'dart:collection';

import 'package:admin/constants.dart';
import 'package:admin/controllers/SearchModel.dart';
import 'package:admin/models/word.dart';
import 'package:admin/repo/LocalDataRepository.dart';
import 'package:admin/screens/dashboard/components/chart.dart';
import 'package:admin/screens/dashboard/components/storage_info_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class HierarchyDetails extends StatelessWidget {
  const HierarchyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(builder: (context, searchModel, child) {
      LocalDataRepository ld = LocalDataRepository.instance;
      var profile = ld.getProfileElonmusk;
      var posts = ld.getPostElonmusk;
      var clses = ld.getTopicsElonmusk;
      if (searchModel.searchText == 'iamsrk') {
        profile = ld.getProfileSrk;
        posts = ld.getPostSrk;
        clses = ld.getTopicsSrk;
      }

      var tweetCounnt = 0;
      var reTweetCount = 0;

      var positivecount = 0;
      var negativeCount = 0;
      var neutralCount = 0;
      var undefinedCount = 0;

      var positivecountTweet = 0;
      var negativeCountTweet = 0;
      var neutralCountTweet = 0;
      var undefinedCountTweet = 0;

      var positivecountRetweet = 0;
      var negativeCountRetweet = 0;
      var neutralCountRetweet = 0;
      var undefinedCountRetweet = 0;

      posts.map((post) {
        tweetCounnt++;
        if (post.quotedTweet.isNotEmpty) {
          tweetCounnt--;
          reTweetCount++;
          if (post.sentiment == 'Positive') {
            positivecountRetweet++;
          } else if (post.sentiment == 'Negative') {
            negativeCountRetweet++;
          } else if (post.sentiment == 'Neutral') {
            neutralCountRetweet++;
          } else if (post.sentiment == 'undefined') {
            undefinedCountRetweet++;
          }
        }
        if (post.sentiment == 'Positive') {
          positivecount++;
        } else if (post.sentiment == 'Negative') {
          negativeCount++;
        } else if (post.sentiment == 'Neutral') {
          neutralCount++;
        } else if (post.sentiment == 'undefined') {
          undefinedCount++;
        }
      }).toList();

      positivecountTweet = positivecount - positivecountRetweet;
      negativeCountTweet = negativeCount - negativeCountRetweet;
      neutralCountTweet = neutralCount - neutralCountRetweet;
      undefinedCountTweet = undefinedCount - undefinedCountRetweet;

      // separate list for every group

      // count total word count
      Map<String, int> totalWordCounts = {};
      for (Word word in clses) {
        if (word.word != null) {
          if (!totalWordCounts.containsKey(word.word!)) {
            totalWordCounts[word.word!] = 0;
          }
          totalWordCounts[word.word!] = totalWordCounts[word.word!]! + 1;
        }
      }
      int totalWordCount = 0;
      for (int count in totalWordCounts.values) {
        totalWordCount += count;
      }

      // print('total word count $totalWordCount');

      // topic class groups
      Map<String, List<Word>> classGroups = {};

      for (Word word in clses) {
        if (word.group != null) {
          if (!classGroups.containsKey(word.group!)) {
            classGroups[word.group!] = [];
          }
          classGroups[word.group!]!.add(word);
        }
      }

      // Create a List of MapEntry objects from the original map.
      List<MapEntry<String, List<Word>>> entriesClassGroups =
          classGroups.entries.toList();

      // Sort the entries list by its value in ascending order.
      entriesClassGroups
          .sort((a, b) => b.value.length.compareTo(a.value.length));

      // Create a new LinkedHashMap and populate it with the sorted entries.
      LinkedHashMap<String, List<Word>> sortedMapClassGroup =
          LinkedHashMap.fromEntries(entriesClassGroups);

      // sentiment groups

      Map<String, List<Word>> sentimentGroups = {};

      for (Word word in clses) {
        if (word.sentiment != null) {
          if (!sentimentGroups.containsKey(word.sentiment!)) {
            sentimentGroups[word.sentiment!] = [];
          }
          sentimentGroups[word.sentiment!]!.add(word);
        }
      }

      // Calculate the frequency of each word in each sentiment group
      Map<String, Map<String, int>> wordCounts = {};
      for (String groupName in sentimentGroups.keys) {
        Map<String, int> counts = {};
        for (Word word in sentimentGroups[groupName]!) {
          if (word.word != null) {
            if (!counts.containsKey(word.word!)) {
              counts[word.word!] = 0;
            }
            counts[word.word!] = counts[word.word!]! + 1;
          }
        }
        wordCounts[groupName] = counts;
      }

// Create the Group objects with the Item objects for each group
      // List<Group> groupList = [];
      Map<String, int> sentimentCountMap = {};
      for (String groupName in sentimentGroups.keys) {
        var wordCountinGroup = 0;
        List<SentimentItem> items = [];
        for (String word in wordCounts[groupName]!.keys) {
          int count = wordCounts[groupName]![word]!;
          wordCountinGroup = wordCountinGroup + count;
          items.add(SentimentItem(word: word, count: count));
        }

        // print(
        //     '-----wordCountinGroup---------------$wordCountinGroup ------ totatl word $totalWordCount');

        double percentage = (wordCountinGroup / totalWordCount) * 100;

        // sort items in descending order based on count
        items.sort((a, b) => b.count.compareTo(a.count));

        // get the top 10 items
        List<SentimentItem> top10Items = [];
        if (items.length > 10) {
          top10Items = items.sublist(0, 10);
        } else {
          top10Items = items;
        }

        // print(
        //     'sentiment name -- $groupName --- word count in group -- $wordCountinGroup -- total word -- $totalWordCount');
        sentimentCountMap[groupName] = wordCountinGroup;
      }

      // Create a List of MapEntry objects from the original map.
      List<MapEntry<String, int>> entries = sentimentCountMap.entries.toList();

      // Sort the entries list by its value in ascending order.
      entries.sort((a, b) => b.value.compareTo(a.value));

      // Create a new LinkedHashMap and populate it with the sorted entries.
      LinkedHashMap<String, int> sortedMap = LinkedHashMap.fromEntries(entries);

      // print(sortedMap);
      int positiveSentiCount = 0;
      int negativeSentiCount = 0;
      int neutralSentiCount = 0;
      for (String sentiment in sortedMap.keys) {
        int count = sortedMap[sentiment]!;
        if (positiveSentiments.contains(sentiment)) {
          positiveSentiCount = positiveSentiCount + count;
        } else if (negativeSentiments.contains(sentiment)) {
          negativeSentiCount = negativeSentiCount + count;
        } else if (neutralSentiments.contains(sentiment)) {
          neutralSentiCount = neutralSentiCount + count;
        } else {
          neutralSentiCount = neutralSentiCount + count;
        }
      }

      // get sentiment counts for each of the classes
      // var result = SplayTreeMap<String,
      //     SplayTreeMap<String, int>>(); // use SplayTreeMap to preserve ordering
      // result = clses.fold(result, (map, word) {
      //   String sentiment = word.sentiment!;
      //   String group = word.group!;
      //   if (!map.containsKey(sentiment)) {
      //     map[sentiment] = SplayTreeMap<String, int>();
      //   }
      //   if (!map[sentiment]!.containsKey(group)) {
      //     map[sentiment]![group] = 0;
      //   }
      //   map[sentiment]![group] = map[sentiment]![group]! + 1;
      //   return map;
      // });

      // print(result);
      Map<String, Map<String, int>> result = {};

// Grouping based on sentiment and group
      for (Word word in clses) {
        String sentiment = word.sentiment!;
        String group = word.group!;

        result[group] ??= {};
        result[group]![sentiment] ??= 0;
        result[group]![sentiment] = result[group]![sentiment]! + 1;
      }

// Printing the result
      // print(result);
      Map<String, List<int>> sentimentCountInClassGroups = {};

      // Iterating over each group's each sentiment count
      for (String group in result.keys) {
        // print("Group: $group");
        var posCount = 0;
        var negCount = 0;
        var neutralCount = 0;
        for (String sentiment in result[group]!.keys) {
          int sentimentCount = result[group]![sentiment]!;
          // print("$sentiment: $sentimentCount");
          if (positiveSentiments.contains(sentiment)) {
            posCount = posCount + sentimentCount;
          } else if (negativeSentiments.contains(sentiment)) {
            negCount = negCount + sentimentCount;
          } else if (neutralSentiments.contains(sentiment)) {
            neutralCount = neutralCount + sentimentCount;
          } else {
            neutralCount = neutralCount + sentimentCount;
          }
        }
        List<int> emolist = [posCount, negCount, neutralCount];
        sentimentCountInClassGroups[group] = emolist;
        // print(" ");
      }

      // get news topic list

//       var newsPosts = ld.getNews;
//       List<String> newsTopics = newsPosts.map((post) => post.topic).toList();
//       print('topicsNews length ' + newsTopics.length.toString());
// // Step 2: Use the Map class to count the frequency of each topic.
//       Map<String, int> newsTopicFrequency = {};
//       for (String topic in newsTopics) {
//         newsTopicFrequency[topic] = (newsTopicFrequency[topic] ?? 0) + 1;
//       }

// // Step 3: Sort the Map in descending order based on the frequency of the topics.
//       List<MapEntry<String, int>> sortedEntriesNews = newsTopicFrequency.entries
//           .toList()
//         ..sort((a, b) => b.value.compareTo(a.value));
// // Step 4: Select the top n topics from the sorted Map.
//       int nw = 10; // change this to select a different number of top topics
//       List<String> topNewsTopics =
//           sortedEntriesNews.take(nw).map((entry) => entry.key).toList();

//       print(topNewsTopics);

      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "All topics",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber),
            ),
            SizedBox(height: defaultPadding),
            Chart(
                paiChartSelectionDatas: getPieChartSelectionDatas(
                    positiveSentiCount,
                    negativeSentiCount,
                    neutralSentiCount,
                    0)),
            ...getInfoCardsAll(
                positiveSentiCount, negativeSentiCount, neutralSentiCount, 0),
            Container(
                color: Colors.green,
                height: 8,
                margin: EdgeInsets.symmetric(vertical: 16)),
            Text(
              "${sortedMapClassGroup.keys.toList()[0]}",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.green),
            ),
            SizedBox(height: defaultPadding),
            Chart(
                paiChartSelectionDatas: getPieChartSelectionDatas(
                    sentimentCountInClassGroups[
                        sortedMapClassGroup.keys.toList()[0]]![0],
                    sentimentCountInClassGroups[
                        sortedMapClassGroup.keys.toList()[0]]![1],
                    sentimentCountInClassGroups[
                        sortedMapClassGroup.keys.toList()[0]]![2],
                    0)),
            ...getInfoCardsAll(
                sentimentCountInClassGroups[
                    sortedMapClassGroup.keys.toList()[0]]![0],
                sentimentCountInClassGroups[
                    sortedMapClassGroup.keys.toList()[0]]![1],
                sentimentCountInClassGroups[
                    sortedMapClassGroup.keys.toList()[0]]![2],
                0),
            Container(
                color: Colors.green,
                height: 8,
                margin: EdgeInsets.symmetric(vertical: 16)),
            Text(
              "${sortedMapClassGroup.keys.toList()[1]}",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
            SizedBox(height: defaultPadding),
            Chart(
                paiChartSelectionDatas: getPieChartSelectionDatas(
                    sentimentCountInClassGroups[
                        sortedMapClassGroup.keys.toList()[1]]![0],
                    sentimentCountInClassGroups[
                        sortedMapClassGroup.keys.toList()[1]]![1],
                    sentimentCountInClassGroups[
                        sortedMapClassGroup.keys.toList()[1]]![2],
                    0)),
            ...getInfoCardsAll(
                sentimentCountInClassGroups[
                    sortedMapClassGroup.keys.toList()[1]]![0],
                sentimentCountInClassGroups[
                    sortedMapClassGroup.keys.toList()[1]]![1],
                sentimentCountInClassGroups[
                    sortedMapClassGroup.keys.toList()[1]]![2],
                0),
            Container(
                color: Colors.green,
                height: 8,
                margin: EdgeInsets.symmetric(vertical: 16)),
            Text(
              "${sortedMapClassGroup.keys.toList()[2]}",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.yellow),
            ),
            SizedBox(height: defaultPadding),
            Chart(
                paiChartSelectionDatas: getPieChartSelectionDatas(
                    sentimentCountInClassGroups[
                        sortedMapClassGroup.keys.toList()[2]]![0],
                    sentimentCountInClassGroups[
                        sortedMapClassGroup.keys.toList()[2]]![1],
                    sentimentCountInClassGroups[
                        sortedMapClassGroup.keys.toList()[2]]![2],
                    0)),
            ...getInfoCardsAll(
                sentimentCountInClassGroups[
                    sortedMapClassGroup.keys.toList()[2]]![0],
                sentimentCountInClassGroups[
                    sortedMapClassGroup.keys.toList()[2]]![1],
                sentimentCountInClassGroups[
                    sortedMapClassGroup.keys.toList()[2]]![2],
                0),
          ],
        ),
      );
    });
  }

  getPieChartSelectionDatas(positive, negative, neutral, undefined) {
    List<PieChartSectionData> paiChartSelectionDatas = [
      PieChartSectionData(
        color: Colors.green,
        value: positive,
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: negative,
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: neutral,
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: Colors.yellow,
        value: undefined,
        showTitle: false,
        radius: 25,
      ),
    ];
    return paiChartSelectionDatas;
  }

  getInfoCardsAll(positive, negative, neutral, undefined) {
    int total = positive + negative + neutral + undefined;

    double posPercentage = (positive / total) * 100;
    double negPercentage = (negative / total) * 100;
    double neuPercentage = (neutral / total) * 100;
    double undPercentage = (undefined / total) * 100;
    // percentage.toStringAsFixed(2)

    return [
      StorageInfoCard(
        svgSrc: "assets/icons/smile.svg",
        title: "Positive",
        amountOfFiles: "${posPercentage.toStringAsFixed(2)} %",
        numOfFiles: positive,
        svgColor: Colors.green,
      ),
      StorageInfoCard(
        svgSrc: "assets/icons/minus-circle.svg",
        title: "Negative",
        amountOfFiles: "${negPercentage.toStringAsFixed(2)} %",
        numOfFiles: negative,
        svgColor: Colors.red,
      ),
      StorageInfoCard(
        svgSrc: "assets/icons/circle.svg",
        title: "Neutral",
        amountOfFiles: "${neuPercentage.toStringAsFixed(2)} %",
        numOfFiles: neutral,
        svgColor: Colors.blue,
      ),
      StorageInfoCard(
        svgSrc: "assets/icons/question-circle.svg",
        title: "Undefined",
        amountOfFiles: "${undPercentage.toStringAsFixed(2)} %",
        numOfFiles: undefined,
        svgColor: Colors.yellow,
      )
    ];
  }
}

class SentimentItem {
  final String word;
  final int count;

  const SentimentItem({required this.word, required this.count});
}
