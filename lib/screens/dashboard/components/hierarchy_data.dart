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

class HierarchyData extends StatelessWidget {
  const HierarchyData({
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

// ----------------
      // Step 1: Collect all topics from the rows into a single list.
      List<String> topics = posts.map((post) => post.topic).toList();
      print('topicstweet length ' + topics.length.toString());
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
      int n = 10; // change this to select a different number of top topics
      List<String> topTopics =
          sortedEntries.take(n).map((entry) => entry.key).toList();

      print(topTopics);

      // Step 1: Collect all topics from the rows into a single list.
      List<String> topicsTweet = posts
          .where((post) =>
              post.quotedTweet.isEmpty) // filter posts with empty quotedTweet
          .map((post) => post.topic)
          .toList();
      print('topicstweet length' + topicsTweet.length.toString());
// Step 2: Use the Map class to count the frequency of each topic.
      Map<String, int> tweetTopicFrequency = {};
      for (String topic in topicsTweet) {
        tweetTopicFrequency[topic] = (tweetTopicFrequency[topic] ?? 0) + 1;
        if (topic.length <= 1) {
          tweetTopicFrequency[topic] = 0;
        }
        if (topic ==
            'This is not a complete social media post so it is not possible to determine') {
          tweetTopicFrequency[topic] = 0;
        }
        if (topic == 'none' || topic == 'Unknown') {
          tweetTopicFrequency[topic] = 0;
        }
      }

// Step 3: Sort the Map in descending order based on the frequency of the topics.
      List<MapEntry<String, int>> sortedEntriesTweet =
          tweetTopicFrequency.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

// Step 4: Select the top n topics from the sorted Map.
      int nt = 10; // change this to select a different number of top topics
      List<String> topTopicsTweet =
          sortedEntriesTweet.take(nt).map((entry) => entry.key).toList();

      print(topTopicsTweet);

      // retweet

      // Step 1: Collect all topics from the rows into a single list.
      List<String> topicsRetweet = posts
          .where((post) => post.quotedTweet
              .isNotEmpty) // filter posts with non-empty quotedTweet
          .map((post) => post.topic)
          .toList();
      print('topicstweet length' + topicsRetweet.length.toString());
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
      int nrt = 10; // change this to select a different number of top topics
      List<String> topTopicsRetweet =
          sortedEntriesRetweet.take(nrt).map((entry) => entry.key).toList();

      print(topTopicsRetweet);

      List<FrequentTopic> frequentTopics = [];
      var noOfTopicsToShow = 10;
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
      print('topicsNews length ' + topics.length.toString());
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
          sortedEntriesNews.take(n).map((entry) => entry.key).toList();

      print(topNewsTopics);

// -----------------------------------------------------------------
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

      print(data_list.length);
      WordCloudData mydata = WordCloudData(data: word_list);

      return Container(
          padding: EdgeInsets.all(defaultPadding),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Expanded(child: ExpandableHierarchyList()),
              Expanded(child: ExpandableHierarchyList()),
            ],
          ));
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
      DataCell(Text(frequentTopic.topic!)),
      DataCell(Text(frequentTopic.topicTweet!)),
      DataCell(Text(frequentTopic.topicRetweet!)),
    ],
  );
}

class FrequentTopic {
  final String? topic, topicTweet, topicRetweet;

  FrequentTopic({this.topic, this.topicTweet, this.topicRetweet});
}

// ----- expandable list --------

class ExpandableHierarchyList extends StatefulWidget {
  @override
  _ExpandableHierarchyListState createState() =>
      _ExpandableHierarchyListState();
}

class _ExpandableHierarchyListState extends State<ExpandableHierarchyList> {
  List<Group> _groups = [
    Group(
      name: 'Personal Information',
      description:
          'This includes topics related to introductions, personal background, and interests.',
      items: [
        Item(name: 'John', count: 10),
        Item(name: 'Mary', count: 5),
        Item(name: 'David', count: 3),
         Item(name: 'David', count: 3),
          Item(name: 'David', count: 3),
           Item(name: 'David', count: 3),
            Item(name: 'David', count: 3),
             Item(name: 'David', count: 3),
              Item(name: 'David', count: 3),
               Item(name: 'David', count: 3),
      ],
    ),
    Group(
      name: 'Current Events',
      description:
          'This includes topics related to local and global news, politics, and social issues.',
      items: [
        Item(name: 'News 1', count: 20),
        Item(name: 'News 2', count: 15),
        Item(name: 'News 3', count: 8),
      ],
    ),
    Group(
      name: 'Hobbies and Interests',
      description:
          'This includes topics related to hobbies, activities, and interests.',
      items: [
        Item(name: 'Hobby 1', count: 12),
        Item(name: 'Hobby 2', count: 6),
        Item(name: 'Hobby 3', count: 2),
      ],
    ),
    // Add more groups here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _groups.length,
        itemBuilder: (context, index) {
          final group = _groups[index];
          return ExpansionTile(
            title: Text(group.name),
            subtitle: Text(group.description),
            children: [
              DataTable(
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Count')),
                ],
                rows: group.items
                    .map((item) => DataRow(
                          cells: [
                            DataCell(Text(item.name)),
                            DataCell(Text(item.count.toString())),
                          ],
                        ))
                    .toList(),
              ),
            ],
          );
        },
      );

    // return GridView.builder(
    //   itemCount: _groups.length,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2, // set the number of columns in the grid
    //     // childAspectRatio: 3 / 2, // set the aspect ratio of each grid item
    //     crossAxisSpacing: 10, // set the horizontal spacing between columns
    //     mainAxisSpacing: 10, // set the vertical spacing between rows
    //   ),
    //   itemBuilder: (context, index) {
    //     final group = _groups[index];
    //     return ExpansionTile(
    //       title: Text(group.name),
    //       subtitle: Text(group.description),
    //       children: [
    //         DataTable(
    //           columns: [
    //             DataColumn(label: Text('Name')),
    //             DataColumn(label: Text('Count')),
    //           ],
    //           rows: group.items
    //               .map((item) => DataRow(
    //                     cells: [
    //                       DataCell(Text(item.name)),
    //                       DataCell(Text(item.count.toString())),
    //                     ],
    //                   ))
    //               .toList(),
    //         ),
    //       ],
    //     );
        // return Card(
        //   child: Column(
        //     children: [
        //       Text(group.name),
        //       Text(group.description),
        //       DataTable(
        //         columns: [
        //           DataColumn(label: Text('Name')),
        //           DataColumn(label: Text('Count')),
        //         ],
        //         rows: group.items
        //           .map((item) => DataRow(
        //             cells: [
        //               DataCell(Text(item.name)),
        //               DataCell(Text(item.count.toString())),
        //             ],
        //           ))
        //           .toList(),
        //       ),
        //     ],
        //   ),
        // );
      // },
    // );
  }
}

class Group {
  final String name;
  final String description;
  final List<Item> items;

  const Group(
      {required this.name, required this.description, required this.items});
}

class Item {
  final String name;
  final int count;

  const Item({required this.name, required this.count});
}
