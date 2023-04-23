import 'package:admin/controllers/SearchModel.dart';
import 'package:admin/models/ElonMuskTweet.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/models/word.dart';
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
      var clses = ld.getTopicsElonmusk;
      if (searchModel.searchText == 'iamsrk') {
        profile = ld.getProfileSrk;
        posts = ld.getPostSrk;
        clses = ld.getTopicsSrk;
      }

      // separate list for every group

      Map<String, List<Word>> groups = {};

      for (Word word in clses) {
        if (word.group != null) {
          if (!groups.containsKey(word.group!)) {
            groups[word.group!] = [];
          }
          groups[word.group!]!.add(word);
        }
      }

      // Calculate the frequency of each word in each group
      Map<String, Map<String, int>> wordCounts = {};
      for (String groupName in groups.keys) {
        Map<String, int> counts = {};
        for (Word word in groups[groupName]!) {
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
      List<Group> groupList = [];
      for (String groupName in groups.keys) {
        List<Item> items = [];
        for (String word in wordCounts[groupName]!.keys) {
          int count = wordCounts[groupName]![word]!;
          items.add(Item(name: word, count: count));
        }
        Group group = Group(
            name: groupName,
            description: "Description for $groupName",
            items: items);
        groupList.add(group);
      }

      int midpoint = groupList.length ~/ 2; // Find the midpoint index

      List<Group> firstHalf =
          groupList.sublist(0, midpoint); // Get the first half of the list
      List<Group> secondHalf =
          groupList.sublist(midpoint); // Get the second half of the list

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
              Expanded(child: ExpandableHierarchyList(groups: firstHalf,)),
              Expanded(child: ExpandableHierarchyList(groups: secondHalf,)),
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
  final List<Group> groups;
  const ExpandableHierarchyList({Key? key, required this.groups})
      : super(key: key);
  @override
  _ExpandableHierarchyListState createState() =>
      _ExpandableHierarchyListState();
}

class _ExpandableHierarchyListState extends State<ExpandableHierarchyList> {
  @override
  Widget build(BuildContext context) {
    List<Group> _groups = widget.groups;

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
                DataColumn(label: Text('Topic')),
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
