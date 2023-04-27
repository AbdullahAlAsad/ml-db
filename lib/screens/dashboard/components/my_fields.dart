import 'package:admin/controllers/SearchModel.dart';
import 'package:admin/models/MyFiles.dart';
import 'package:admin/models/tweet.dart';
import 'package:admin/repo/LocalDataRepository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/tweet_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
    this.crossAxisCount = 3,
    this.childAspectRatio = 2,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

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
      var tweetCounnt = 0;
      var reTweetCount = 0;
      // posts.map((post) {
      //   tweetCounnt++;
      //   if (post.quotedTweet.isNotEmpty) {
      //     tweetCounnt--;
      //     reTweetCount++;
      //   }
      // }).toList();
      // print('tweetcount -- $tweetCounnt -------retweetcount --------$reTweetCount');

      tweets.map((post) {
        if (post.quotedTweet!.isNotEmpty) {
          reTweetCount++;
        } else {
          tweetCounnt++;
        }
      }).toList();
      print(
          'tweetcount -- $tweetCounnt -------retweetcount --------$reTweetCount');
      List stats = [
        // CloudStorageInfo(
        //   title: "Status",
        //   numOfFiles: int.parse(profile.statusesCount),
        //   svgSrc: "assets/icons/message-circle-blank.svg",
        //   totalStorage: "3 Month",
        //   color: primaryColor,
        //   percentage: 100,
        // ),
        CloudStorageInfo(
          title: "Tweet",
          numOfFiles: tweetCounnt,
          svgSrc: "assets/icons/message-circle-dots.svg",
          totalStorage: "4 Month",
          color: Color(0xFFFFA113),
          percentage: 100,
        ),
        CloudStorageInfo(
          title: "Retweet",
          numOfFiles: reTweetCount,
          svgSrc: "assets/icons/message-circle-refresh.svg",
          totalStorage: "4 Month",
          color: Color(0xFFA4CDFF),
          percentage: 100,
        ),
        CloudStorageInfo(
          title: "Followers",
          numOfFiles: int.parse(profile.followersCount),
          svgSrc: "assets/icons/team-member.svg",
          totalStorage: "4 Month",
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
        itemBuilder: (context, index) => Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            StatInfoCard(info: stats[index]),
            if (index == 0)
              Expanded(
                child: TweetBarChart(
                    tweetCountByMonth: countTweetsByMonth(tweets)),
              ),
            if (index == 1)
              Expanded(
                child: TweetBarChart(
                    tweetCountByMonth:
                        countTweetsByMonth(tweets, isTweet: false)),
              )
          ],
        ),
      );
    });
  }

  Map<String, int> countTweetsByMonth(List<Tweet> tweets,
      {bool isTweet = true}) {
    Map<String, int> tweetCountByMonth = {};

    for (Tweet tweet in tweets) {
      if (tweet.date != null) {
        DateTime tweetDate = DateTime.parse(tweet.date!);
        String monthYear = DateFormat('MMM yyyy').format(tweetDate);
        if (!isTweet) {
          // count retweet
          if (tweet.quotedTweet!.isNotEmpty) {
            if (tweetCountByMonth.containsKey(monthYear)) {
              tweetCountByMonth[monthYear] = tweetCountByMonth[monthYear]! + 1;
            } else {
              tweetCountByMonth[monthYear] = 1;
            }
          }
        } else {
          if (tweetCountByMonth.containsKey(monthYear)) {
            tweetCountByMonth[monthYear] = tweetCountByMonth[monthYear]! + 1;
          } else {
            tweetCountByMonth[monthYear] = 1;
          }
        }
      }
    }

    return tweetCountByMonth;
  }
}
