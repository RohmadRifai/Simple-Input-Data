import 'package:flutter/material.dart';
import 'package:latihan/database/database_service.dart';

import '../model/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  List<Data> datas = [];

  void readDatas() async {
    datas = await DatabaseHelper.instance.readDatas();
    setState(() {});
  }

  @override
  void initState() {
    readDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latihan')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            nama(),
            alamat(),
            simpan(),
            Row(
              children: const [
                Expanded(child: Text('Nama')),
                Expanded(child: Text('Alamat'))
              ],
            ),
            const SizedBox(height: 10),
            hasil()
          ],
        ),
      ),
    );
  }

  Widget nama() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const SizedBox(width: 70, child: Text('Nama')),
            Expanded(
              child: TextField(
                controller: namaController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), isDense: true),
              ),
            )
          ],
        ),
      );
  Widget alamat() => Row(
        children: [
          const SizedBox(width: 70, child: Text('Alamat')),
          Expanded(
            child: TextField(
              controller: alamatController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), isDense: true),
            ),
          )
        ],
      );
  Widget simpan() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton(
            child: const Text('Simpan'),
            onPressed: () async {
              await DatabaseHelper.instance.createData(Data(
                  nama: namaController.text, alamat: alamatController.text));
              readDatas();
              namaController.clear();
              alamatController.clear();
            }),
      );
  Widget hasil() => Expanded(
        child: ListView.builder(
          itemCount: datas.length,
          itemBuilder: (BuildContext context, int index) => Row(children: [
            Expanded(child: Text(datas[index].nama)),
            Expanded(child: Text(datas[index].alamat))
          ]),
        ),
      );
}
