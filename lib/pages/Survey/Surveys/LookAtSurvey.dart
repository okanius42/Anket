import 'package:flutter/material.dart';
import 'package:survey/Drawer.dart';

class LookAtSurvey extends StatefulWidget {
  bool isCheck;
  List list;
  int surveyID;
  LookAtSurvey(
      {super.key,
      required this.isCheck,
      required this.list,
      required this.surveyID});

  @override
  State<LookAtSurvey> createState() => _LookAtSurveyState();
}

class _LookAtSurveyState extends State<LookAtSurvey> {
  int _selectedIndex = 0;
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height =
        size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    final List<Widget> bottomBarWidget = <Widget>[
      //Survey
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: height * .01102941155,
              vertical: size.width * .023611110661),
          child: Center(
              child: Column(
            children: [
              const Text('Topic'),
              SizedBox(
                height: size.height * .01433823502,
              ),
              const Text("explain"),
              SizedBox(
                height: size.height * .01433823502,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Scrollbar(
                  controller: _scrollController,
                  child: ListView.builder(itemBuilder: (ctx, index) {
                    return const Card(child: Text('check box list tile'));
                  }),
                ),
              )
            ],
          )),
        ),
      ),
      //Answer
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: height * .01102941155,
              vertical: size.width * .023611110661),
          child: Center(
              child: Column(
            children: [
              const Text('Topic'),
              SizedBox(
                height: size.height * .01433823502,
              ),
              const Text("explain"),
              SizedBox(
                height: size.height * .01433823502,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Scrollbar(
                  controller: _scrollController,
                  child: ListView.builder(itemBuilder: (ctx, index) {
                    return Card(
                      child: Row(
                        children: [
                          const Text('Choice'),
                          const Text('Cevap Sayısı'),
                          const Text('Cevap Yüzdesi')
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          )),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: bottomBarWidget.elementAt(_selectedIndex),
      drawer: drawerBuild(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedIconTheme: const IconThemeData(opacity: .40),
        selectedIconTheme: const IconThemeData(opacity: 1, color: Colors.black),
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: true,
        iconSize: 24,
        mouseCursor: MouseCursor.uncontrolled,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Anket'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Cevapla')
        ],
      ),
    );
  }
}
