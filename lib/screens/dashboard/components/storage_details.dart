import 'package:admin/controllers/SearchModel.dart';
import 'package:admin/repo/LocalDataRepository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(builder: (context, searchModel, child) {
      LocalDataRepository ld = LocalDataRepository.instance;
      var profile = ld.getProfileElonmusk;
      var posts = ld.getPostElonmusk;
      if (searchModel.searchText == 'iamsrk') {
        profile = ld.getProfileSrk;
        posts = ld.getPostSrk;
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


      // get news topic list

            var newsPosts = ld.getNews;
      List<String> newsTopics = newsPosts.map((post) => post.topic).toList();
      // print('topicsNews length ' + newsTopics.length.toString());
// Step 2: Use the Map class to count the frequency of each topic.
      Map<String, int> newsTopicFrequency = {};
      for (String topic in newsTopics) {
        newsTopicFrequency[topic] = (newsTopicFrequency[topic] ?? 0) + 1;
      }

// Step 3: Sort the Map in descending order based on the frequency of the topics.
      List<MapEntry<String, int>> sortedEntriesNews = newsTopicFrequency.entries
          .toList()
        ..sort((a, b) => b.value.compareTo(a.value));
// Step 4: Select the top n topics from the sorted Map.
      int nw = 10; // change this to select a different number of top topics
      List<String> topNewsTopics =
          sortedEntriesNews.take(nw).map((entry) => entry.key).toList();

      // print(topNewsTopics);

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
              "Post Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: defaultPadding),
            Chart(
                paiChartSelectionDatas: getPieChartSelectionDatas(positivecount,
                    negativeCount, neutralCount, undefinedCount)),
            ...getInfoCardsAll(
                positivecount, negativeCount, neutralCount, undefinedCount),
                            Text(
              "Frequent 10 News Topics",
              style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.red),
            ),
                            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: Text("In News Headlines",style: Theme.of(context).textTheme.titleLarge?.apply(color: Colors.blue)),
                  ),
                ],
                rows: List.generate(
                  topNewsTopics.length,
                  (index) => DataRow(cells: [
                    DataCell(Text(topNewsTopics[index])),
                  ]),
                ),
              ),
            ),

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
        amountOfFiles:"${undPercentage.toStringAsFixed(2)} %",
        numOfFiles: undefined,
        svgColor: Colors.yellow,
      )
    ];
  }
}
