import 'package:flutter/material.dart';

void PopUpWidget(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Informacion'),
        content: const Text(
            'Esta aplicación te permite realizar pruebas de velocidad de Internet. '
            'Mide la velocidad de descarga y carga de tu conexión. '
            '¡Presiona "Iniciar Test" para comenzar y cancela en cualquier momento!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cerrar'),
          ),
        ],
      );
    },
  );
}
