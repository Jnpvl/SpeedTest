// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const _titles(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => _cardData(),
              separatorBuilder: (context, index) => Divider(),
              itemCount: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _cardData extends StatelessWidget {
  const _cardData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        //color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            //color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '05/01/2023',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  '192.90.20',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                  // color: Colors.red,
                  child: Center(
                      child: Text(
            '82.4d0',
            style: TextStyle(fontWeight: FontWeight.bold),
          )))),
          Expanded(
              child: Container(
                  //color: Colors.yellow,
                  child: Center(
                      child: Text('82.40',
                          style: TextStyle(fontWeight: FontWeight.bold))))),
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
