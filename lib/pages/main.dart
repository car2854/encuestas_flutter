import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/widget.dart';
import 'package:flutter/material.dart';

class MainPages extends StatelessWidget {
  const MainPages({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(125),
            child: AppBarWidget(),
          ),
          bottomNavigationBar: menu(),
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              PollWidget(),
              MyPollWidget(),
              VotedPollWidget()
            ],
          ),
        ),
      )
    );
  }

  Widget menu() {
    return Container(
      color: ColorTheme.colorPrimary,
      child: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.white,
        tabs: [
          Tab(
            text: "Encuestas",
            icon: Icon(Icons.description)
          ),
          Tab(
            text: "Mis encuestas",
            icon: Icon(Icons.book),
          ),
          Tab(
            text: "Mis participaciones",
            icon: Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}


