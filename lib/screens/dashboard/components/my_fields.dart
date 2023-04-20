import 'package:admin/controllers/SearchModel.dart';
import 'package:admin/models/MyFiles.dart';
import 'package:admin/repo/LocalDataRepository.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Statistics",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // ElevatedButton.icon(
            //   style: TextButton.styleFrom(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: defaultPadding * 1.5,
            //       vertical:
            //           defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            //     ),
            //   ),
            //   onPressed: () {},
            //   icon: Icon(Icons.add),
            //   label: Text("Add New"),
            // ),
            Text(
              "Updated 1 day ago",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

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
      posts.map((post) {
        tweetCounnt++;
        if (post.quotedTweet.isNotEmpty) {
          tweetCounnt--;
          reTweetCount++;
        }
      }).toList();
      // print('tweetcount -- $tweetCounnt -------retweetcount --------$reTweetCount');

      List stats = [
        CloudStorageInfo(
          title: "Status",
          numOfFiles: int.parse(profile.statusesCount),
          svgSrc: "assets/icons/message-circle-blank.svg",
          totalStorage: "3 Month",
          color: primaryColor,
          percentage: 100,
        ),
        CloudStorageInfo(
          title: "Tweet",
          numOfFiles: tweetCounnt,
          svgSrc: "assets/icons/message-circle-dots.svg",
          totalStorage: "3 Month",
          color: Color(0xFFFFA113),
          percentage: 100,
        ),
        CloudStorageInfo(
          title: "Retweet",
          numOfFiles: reTweetCount,
          svgSrc: "assets/icons/message-circle-refresh.svg",
          totalStorage: "3 Month",
          color: Color(0xFFA4CDFF),
          percentage: 100,
        ),
        CloudStorageInfo(
          title: "Followers",
          numOfFiles: int.parse(profile.followersCount),
          svgSrc: "assets/icons/team-member.svg",
          totalStorage: "3 Month",
          color: Color(0xFF007EE5),
          percentage: 100,
        ),
      ];

      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: stats.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) => StatInfoCard(info: stats[index]),
      );
    });
  }
}
