import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/controllers/SearchModel.dart';
import 'package:admin/repo/LocalDataRepository.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
   ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalDataRepository ld = LocalDataRepository.instance;


    return Consumer<SearchModel>(
      builder: (context, searchModel, child) {
    var profile = ld.getProfileElonmusk;
    if(searchModel.searchText == 'iamsrk')
      profile = ld.getProfileSrk;
        return Container(
          margin: EdgeInsets.only(left: defaultPadding),
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Image.network(
               profile.profileImageUrl,
                height: 38,
              ),
              if (!Responsive.isMobile(context))
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  child: Text( profile.displayname ??  "Angelina Jolie"),
                ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        );
      }
    );
  }
}

class SearchField extends StatelessWidget {
  var textController = TextEditingController();
  SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final searchModel = Provider.of<SearchModel>(context);
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {
            searchModel.searchText = textController.text;
          //   print(textController.text);
          //  changeCurrentProfile(textController.text);
          },
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
