import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:speedtest/components/historyWidget.dart';
import 'package:speedtest/components/popUpWidget.dart';
import 'package:speedtest/styles/waveStyle.dart';

import '../components/speedTestWidget.dart';
import '../services/speedTest.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Borrado'),
          content: Text('¿Estás seguro de que quieres borrar el historial?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Borrar'),
              onPressed: () {
                _deleteHistory(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteHistory(BuildContext context) async {
    final localStorage = LocalStorage('speed_test_data');
    await localStorage.ready;
    localStorage.deleteItem('history');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Historial borrado')));
  }

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
                GestureDetector(
                  onTap: () => _showDeleteConfirmation(context),
                  child: Icon(Icons.delete, color: Colors.black),
                ),
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
                'Internet Speed',
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
