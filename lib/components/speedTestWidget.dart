import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';

import '../services/speedTest.dart';

class SpeedTestWidget extends StatefulWidget {
  final SpeedTestManager speedTestManager;

  SpeedTestWidget({required this.speedTestManager});

  @override
  _SpeedTestWidgetState createState() => _SpeedTestWidgetState();
}

class _SpeedTestWidgetState extends State<SpeedTestWidget> {
  final FlareControls _flareControls = FlareControls();

  bool _testInProgress = false;
  double _downloadRate = 0;
  double _uploadRate = 0;
  String _downloadProgress = '0';
  String _uploadProgress = '0';
  int _downloadCompletionTime = 0;
  int _uploadCompletionTime = 0;
  bool _isServerSelectionInProgress = false;

  String? _ip;
  String? _asn;
  String? _isp;

  String _unitText = 'Mbps';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: _dowloadUpload(
            downloadRate: _downloadRate,
            unitText: _unitText,
            uploadRate: _uploadRate,
            downloadCompletionTime: _downloadCompletionTime,
            uploadCompletionTime: _uploadCompletionTime,
          ),
        ),
        SizedBox(height: 10),
        Container(margin: EdgeInsets.all(20), child: accionButton()),
        SizedBox(height: 10),
        Container(child: _Information(isp: _isp, ip: _ip)),
      ],
    );
  }

  InkWell accionButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          children: [
            Container(
                child: Image.asset(
              'assets/pato.gif',
              width: 150,
              height: 150,
            )),
            Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  _testInProgress ? 'Cancelar test' : 'Iniciar Test',
                  style: TextStyle(color: Colors.white),
                )))
          ],
        ),
      ),
      onTap: () async {
        if (_testInProgress) {
          widget.speedTestManager.cancelSpeedTest();
        } else {
          reset();
          await widget.speedTestManager.startSpeedTest(
            onStarted: () {
              setState(() => _testInProgress = true);
            },
            onCompleted: (TestResult download, TestResult upload) {
              setState(() {
                _downloadRate = download.transferRate;
                _unitText = download.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                _downloadProgress = '100';
                _downloadCompletionTime = download.durationInMillis;
              });
              setState(() {
                _uploadRate = upload.transferRate;
                _unitText = upload.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                _uploadProgress = '100';
                _uploadCompletionTime = upload.durationInMillis;
                _testInProgress = false;
              });
            },
            onProgress: (double percent, TestResult data) {
              setState(() {
                _unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                if (data.type == TestType.download) {
                  _downloadRate = data.transferRate;
                  _downloadProgress = percent.toStringAsFixed(2);
                } else {
                  _uploadRate = data.transferRate;
                  _uploadProgress = percent.toStringAsFixed(2);
                }
              });
            },
            onError: (String errorMessage, String speedTestError) {
              reset();
            },
            onDefaultServerSelectionInProgress: () {
              setState(() {
                _isServerSelectionInProgress = true;
              });
            },
            onDefaultServerSelectionDone: (Client? client) {
              setState(() {
                _isServerSelectionInProgress = false;
                _ip = client?.ip;
                _asn = client?.asn;
                _isp = client?.isp;
              });
            },
            onDownloadComplete: (TestResult data) {
              setState(() {
                _downloadRate = data.transferRate;
                _unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                _downloadCompletionTime = data.durationInMillis;
              });
            },
            onUploadComplete: (TestResult data) {
              setState(() {
                _uploadRate = data.transferRate;
                _unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                _uploadCompletionTime = data.durationInMillis;
              });
            },
            onCancel: () {
              reset();
            },
          );
        }
      },
    );
  }

  void reset() {
    setState(() {
      _testInProgress = false;
      _downloadRate = 0;
      _uploadRate = 0;
      _downloadProgress = '0';
      _uploadProgress = '0';
      _unitText = 'Mbps';
      _downloadCompletionTime = 0;
      _uploadCompletionTime = 0;

      _ip = null;
      _asn = null;
      _isp = null;
    });
  }
}

class _dowloadUpload extends StatelessWidget {
  _dowloadUpload({
    super.key,
    required double downloadRate,
    required String unitText,
    required double uploadRate,
    required int downloadCompletionTime,
    required int uploadCompletionTime,
  })  : _downloadRate = downloadRate,
        _unitText = unitText,
        _uploadRate = uploadRate,
        _downloadCompletionTime = downloadCompletionTime,
        _uploadCompletionTime = uploadCompletionTime;

  final double _downloadRate;
  final String _unitText;
  final double _uploadRate;
  final int _downloadCompletionTime;
  final int _uploadCompletionTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
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
              Text('$_downloadRate $_unitText',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.deepPurple)),
              Text(
                  'Time: ${(_downloadCompletionTime / 1000).toStringAsFixed(2)} sec(s)',
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
              Text('$_uploadRate $_unitText',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.deepPurple)),
              Text(
                  'Time: ${(_uploadCompletionTime / 1000).toStringAsFixed(2)} sec(s)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.deepPurple))
            ],
          ),
        ),
      ],
    );
  }
}

class _Information extends StatelessWidget {
  const _Information({
    super.key,
    required String? isp,
    required String? ip,
  })  : _isp = isp,
        _ip = ip;

  final String? _isp;
  final String? _ip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _isp != null && _isp!.isNotEmpty ? '$_isp' : 'Company',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(_ip != null && _ip!.isNotEmpty ? '$_ip' : 'IP'),
      ],
    );
  }
}
