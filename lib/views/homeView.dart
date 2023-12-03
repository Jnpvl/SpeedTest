import 'package:flutter/material.dart';
import 'package:speedtest/components/historyWidget.dart';
import 'package:speedtest/components/popUpWidget.dart';
import 'package:speedtest/styles/waveStyle.dart';

import '../components/speedTestWidget.dart';
import '../services/speedTest.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final SpeedTestManager speedTestManager = SpeedTestManager();

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('X'),
                Text(
                  'Speed Test',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () {
                      PopUpWidget(context);
                    },
                    child: Icon(Icons.help_outline)),
              ],
            ),
            bottom: TabBar(tabs: [
              Tab(
                  child: Text(
                'Interntet Speed',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Tab(
                  child: Text('History',
                      style: TextStyle(fontWeight: FontWeight.bold)))
            ]),
          ),
          body: TabBarView(children: [
            WaveContainer(
                child: SpeedTestWidget(speedTestManager: speedTestManager)),
            HistoryWidget()
          ]),
        ));
  }
}
