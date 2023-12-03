import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localStorage = LocalStorage('speed_test_data');

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const _titles(),
          Expanded(
            child: FutureBuilder(
              future: localStorage.ready,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<dynamic> history = localStorage.getItem('history') ?? [];
                  if (history.isEmpty) {
                    return Center(
                      child: Text("No hay datos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    );
                  }
                  List<dynamic> reversedHistory = history.reversed.toList();
                  return ListView.separated(
                    itemCount: reversedHistory.length,
                    itemBuilder: (context, index) {
                      var data = reversedHistory[index];
                      return _cardData(
                        date: data['date'],
                        ip: data['ip'],
                        downloadSpeed: '${data['downloadSpeed']} Mbps',
                        uploadSpeed: '${data['uploadSpeed']} Mbps',
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _cardData extends StatelessWidget {
  final String date;
  final String ip;
  final String downloadSpeed;
  final String uploadSpeed;

  const _cardData({
    Key? key,
    required this.date,
    required this.ip,
    required this.downloadSpeed,
    required this.uploadSpeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateTime =
        DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(date));
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateTime,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  ip,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                downloadSpeed,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                uploadSpeed,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _titles extends StatelessWidget {
  const _titles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
        ),
        color: const Color.fromARGB(255, 244, 243, 243),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text(
              'DATE',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.download, color: Colors.deepPurple),
                    Text('DOWNLOAD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple)),
                  ],
                ),
                Text('Mbps',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.deepPurple))
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.upload, color: Colors.deepPurple),
                    Text('UPLOAD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple)),
                  ],
                ),
                Text('Mbps',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.deepPurple))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
