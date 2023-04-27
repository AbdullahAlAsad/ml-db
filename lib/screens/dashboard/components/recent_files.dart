import 'package:admin/controllers/SearchModel.dart';
import 'package:admin/models/ElonMuskTweet.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/repo/LocalDataRepository.dart';
// import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:word_cloud/word_cloud_data.dart';
import 'package:word_cloud/word_cloud_view.dart';

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(builder: (context, searchModel, child) {
      LocalDataRepository ld = LocalDataRepository.instance;
      var profile = ld.getProfileElonmusk;
      // var posts = ld.getPostElonmusk;
      var tweets = ld.getTweetsElonmusk;
      if (searchModel.searchText == 'iamsrk') {
        profile = ld.getProfileSrk;
        // posts = ld.getPostSrk;
        tweets = ld.getTweetsSrk;
      }

//       // Step 1: Collect all topics from the rows into a single list.
//       List<String> topics = posts.map((post) => post.topic).toList();
//       print('topicstweet length ' + topics.length.toString());
// // Step 2: Use the Map class to count the frequency of each topic.
//       Map<String, int> topicFrequency = {};
//       for (String topic in topics) {
//         topicFrequency[topic] = (topicFrequency[topic] ?? 0) + 1;
//         if (topic.length <= 1) {
//           topicFrequency[topic] = 0;
//         }
//         if (topic ==
//             'This is not a complete social media post so it is not possible to determine') {
//           topicFrequency[topic] = 0;
//         }
//         if (topic == 'none' || topic == 'Unknown') {
//           topicFrequency[topic] = 0;
//         }
//       }

      // Step 1: Collect all topics from the rows into a single list.
    List<String> topics = tweets.expand((post) => (post.topic ?? []).cast<String>()).toList();


      // print('topicstweet length ' + topics.length.toString());
// Step 2: Use the Map class to count the frequency of each topic.
      Map<String, int> topicFrequency = {};
      for (String topic in topics) {
        topicFrequency[topic] = (topicFrequency[topic] ?? 0) + 1;
        if (topic.length <= 1) {
          topicFrequency[topic] = 0;
        }
        if (topic ==
            'This is not a complete social media post so it is not possible to determine') {
          topicFrequency[topic] = 0;
        }
        if (topic == 'none' || topic == 'Unknown') {
          topicFrequency[topic] = 0;
        }
      }



// Step 3: Sort the Map in descending order based on the frequency of the topics.
      List<MapEntry<String, int>> sortedEntries = topicFrequency.entries
          .toList()
        ..sort((a, b) => b.value.compareTo(a.value));

        

// Step 4: Select the top n topics from the sorted Map.
      int n = 20; // change this to select a different number of top topics
      List<String> topTopics =
          sortedEntries.take(n).map((entry) => entry.key).toList();
// List<String> topTopicsRetweet = sortedEntriesRetweet.take(nrt).map((entry) => entry.key).where((topic) => topic.length > 3).toList();
// .where((topic) => topic.length > 3)
      // print(topTopics);

      // Step 1: Collect all topics from the rows into a single list.
      List<String> topicsTweet = tweets
          .where((post) =>
              post.quotedTweet!.isEmpty) // filter posts with empty quotedTweet
          .expand((post) => (post.topic ?? []).cast<String>()).toList();
      // print('topicstweet length--' + topicsTweet.length.toString());
// Step 2: Use the Map class to count the frequency of each topic.
      Map<String, int> tweetTopicFrequency = {};
      for (String topic in topicsTweet) {
        tweetTopicFrequency[topic.toLowerCase()] = (tweetTopicFrequency[topic] ?? 0) + 1;
        if (topic.length <= 1) {
          tweetTopicFrequency[topic] = 0;
        }
        if (topic ==
            'This is not a complete social media post so it is not possible to determine') {
          tweetTopicFrequency[topic] = 0;
        }
        if (topic == 'none' || topic == 'Unknown' || topic == 'unknown') {
          tweetTopicFrequency[topic] = 0;
        }
      }

// Step 3: Sort the Map in descending order based on the frequency of the topics.
      List<MapEntry<String, int>> sortedEntriesTweet =
          tweetTopicFrequency.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

// Step 4: Select the top n topics from the sorted Map.
      int nt = 20; // change this to select a different number of top topics
      List<String> topTopicsTweet =
          sortedEntriesTweet.take(nt).map((entry) => entry.key).toList();
//where((topic) => topic.length > 3).
      // print(topTopicsTweet);

      // retweet

      // Step 1: Collect all topics from the rows into a single list.
      List<String> topicsRetweet = tweets
          .where((post) => post.quotedTweet!
              .isNotEmpty) // filter posts with non-empty quotedTweet
           .expand((post) => (post.topic ?? []).cast<String>()).toList();
      // print('topicstweet length' + topicsRetweet.length.toString());
// Step 2: Use the Map class to count the frequency of each topic.
      Map<String, int> retweetTopicFrequency = {};
      for (String topic in topicsRetweet) {
        retweetTopicFrequency[topic] = (retweetTopicFrequency[topic] ?? 0) + 1;
        if (topic.length <= 1) {
          retweetTopicFrequency[topic] = 0;
        }
        if (topic ==
            'This is not a complete social media post so it is not possible to determine') {
          retweetTopicFrequency[topic] = 0;
        }
        if (topic == 'none' || topic == 'Unknown') {
          retweetTopicFrequency[topic] = 0;
        }
      }

// Step 3: Sort the Map in descending order based on the frequency of the topics.
      List<MapEntry<String, int>> sortedEntriesRetweet =
          retweetTopicFrequency.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

// Step 4: Select the top n topics from the sorted Map.
      int nrt = 20; // change this to select a different number of top topics
      List<String> topTopicsRetweet =
          sortedEntriesRetweet.take(nrt).map((entry) => entry.key).toList();
// .where((topic) => topic.length > 3)
      // print(topTopicsRetweet);

      List<FrequentTopic> frequentTopics = [];
      var noOfTopicsToShow = 20;
      for (var i = 0; i < noOfTopicsToShow; i++) {
        FrequentTopic fq = new FrequentTopic(
            topic: topTopics[i],
            topicTweet: topTopicsTweet[i],
            topicRetweet: topTopicsRetweet[i]);
        frequentTopics.add(fq);
      }
// news topics
      // Step 1: Collect all topics from the rows into a single list.
      var newsPosts = ld.getNews;
      List<String> newsTopics = newsPosts.map((post) => post.topic).toList();
      // print('topicsNews length ' + topics.length.toString());
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
      int nw = 20; // change this to select a different number of top topics
      List<String> topNewsTopics =
          sortedEntriesNews.take(n).map((entry) => entry.key).toList();

      // print(topNewsTopics);
      List<Map> data_list = [];

      // for (var i = 0; i < sortedEntriesNews.length; i++) {
      //   // print(sortedEntriesNews[i].key);
      //   // print(sortedEntriesNews[i].value);
      //   data_list.add({
      //     'word': sortedEntriesNews[i].key,
      //     'value': sortedEntriesNews[i].value
      //   });
      // }

      List<Map> word_list = [
        {'word': 'Apple', 'value': 100},
        {'word': 'Samsung', 'value': 60},
        {'word': 'Intel', 'value': 55},
        {'word': 'Tesla', 'value': 50},
        {'word': 'AMD', 'value': 40},
        {'word': 'Google', 'value': 35},
        {'word': 'Qualcom', 'value': 31},
        {'word': 'Netflix', 'value': 27},
      ];

      // print(data_list.length);
      WordCloudData mydata = WordCloudData(data: word_list);
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
              "Top 10 Topics",
              style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.yellow),
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: defaultPadding,
                headingRowColor: MaterialStateProperty.all<Color?>(Color.fromARGB(255, 102, 102, 69)),
                dividerThickness: 4,
                showBottomBorder: true,
                border: TableBorder.all(color: Colors.blue,width: 4),
                dataRowColor: MaterialStateProperty.all<Color?>(Color.fromARGB(255, 14, 27, 77)),
                columns: [
                  DataColumn(
                    label: Text("In All Posts", style: Theme.of(context).textTheme.titleLarge?.apply(color: Color(0xFFFFA113)),),
                  ),
                  DataColumn(
                    label: Text("In Tweets", style: Theme.of(context).textTheme.titleLarge?.apply(color: Color(0xFFA4CDFF)),),
                  ),
                  DataColumn(
                    label: Text("In Retweets", style: Theme.of(context).textTheme.titleLarge?.apply(color: Color(0xFF007EE5)),),
                  ),
                ],
                rows: List.generate(
                 10,
                  (index) => recentFileDataRow(frequentTopics[index]),
                ),
              ),
            ),
            // Text(
            //   "Frequent 10 News Headlines",
            //   style: Theme.of(context).textTheme.subtitle1,
            // ),
            // SizedBox(
            //   width: double.infinity,
            //   child: DataTable(
            //     columnSpacing: defaultPadding,
            //     columns: [
            //       DataColumn(
            //         label: Text("News Headlines"),
            //       ),
            //     ],
            //     rows: List.generate(
            //       demoRecentFiles.length,
            //       (index) => DataRow(cells: [
            //         DataCell(Text(topNewsTopics[index])),
            //       ]),
            //     ),
            //   ),
            // ),
            // WordCloudView(
            //   data: mydata,
            //   mapwidth: 500,
            //   mapheight: 300,
            //   colorlist: [Colors.black, Colors.redAccent, Colors.indigoAccent],
            //   mapcolor:  Color.fromARGB(255, 174, 183, 235),
            // )
          ],
        ),
      );
    });
  }
}

DataRow recentFileDataRow(FrequentTopic frequentTopic) {
  return DataRow(
    cells: [
      // DataCell(
      //   Row(
      //     children: [
      //       SvgPicture.asset(
      //         frequentTopic.icon!,
      //         height: 30,
      //         width: 30,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      //         child: Text(frequentTopic.title!),
      //       ),
      //     ],
      //   ),
      // ),
      DataCell(Text(frequentTopic.topic!,style: TextStyle(color: Color(0xFFFFA113)),)),
      DataCell(Text(frequentTopic.topicTweet!,style: TextStyle(color: Color(0xFFA4CDFF)))),
      DataCell(Text(frequentTopic.topicRetweet!,style: TextStyle(color: Color(0xFF007EE5)))),
    ],
  );
}

class FrequentTopic {
  final String? topic, topicTweet, topicRetweet;

  FrequentTopic({this.topic, this.topicTweet, this.topicRetweet});
}
