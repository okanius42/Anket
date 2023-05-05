import 'package:flutter/material.dart';
import 'package:survey/Services/Firestore_services.dart';

import '../Drawer.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  StatsService _statsService = StatsService();
  @override
  Widget build(BuildContext context) {
    List<String> stats = [
      'Toplam Anket Sayısı',
      'Cevaplanan Anket Sayısı',
      'Kulllanıcı Sayısı',
      'Günlük Cevaplama Sayısı'
    ];
    List<Widget> _widgetList = [
      FutureBuilder(
          future: _statsService.getSurveyData(),
          builder: (context, snapshot) {
            return Text(snapshot.data.toString());
          }),
      FutureBuilder(
          future: _statsService.getAnswerData(),
          builder: (context, snapshot) {
            return Text(snapshot.data.toString());
          }),
      FutureBuilder(
          future: _statsService.getUserData(),
          builder: (context, snapshot) {
            return Text(snapshot.data.toString());
          }),
      Text('5')
    ];

    var size = MediaQuery.of(context).size;
    var height =
        size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.width * .02361111066),
            child: Container(
              height: height * .95,
              width: size.width * .95,
              child: Padding(
                padding: EdgeInsets.only(top: height * .02105736876),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: stats.length,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(stats.elementAt(index)),
                          SizedBox(
                            height: height * .01,
                          ),
                          _widgetList.elementAt(index)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        drawer: drawerBuild());
  }
}
