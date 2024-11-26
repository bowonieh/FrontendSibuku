import 'package:flutter/material.dart';
import 'package:frontendbukuxirpla/config/config.dart';
import 'package:frontendbukuxirpla/model/data_bukumodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BukuPages extends StatefulWidget {
  const BukuPages({super.key});

  @override
  State<BukuPages> createState() => _BukuPagesState();
}

class _BukuPagesState extends State<BukuPages> {
  final TextEditingController textPencarian = TextEditingController();
  List<DataBuku> pencarianBuku = [];
  //Tampilan loading Default list Buku
  Widget listBuku = const Center(
    child: CircularProgressIndicator(),
  );
  void cariData(String query) async {
    if (query.isEmpty) {
      ambilData();
    } else {
      setState(() {
        listBuku = const Center(
          child: CircularProgressIndicator(),
        );
      });
      try {
        final response =
            //await http.get(Uri.parse(ConfigApps.url + ConfigApps.listBuku));
            await http.post(Uri.parse(ConfigApps.url + ConfigApps.cariBuku),
                body: {'item': query});
        if (response.statusCode == 200) {
          final databuku = dataBukuFromJson(response.body);
          if (mounted) {
            setState(() {
              pencarianBuku = databuku;
              if (databuku.isEmpty) {
                Get.snackbar("Kosong", "tidak ada data",
                    backgroundColor: Colors.red);
              } else {
                listBuku = ListView.builder(
                  itemCount: databuku.length,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        //Aksi klik pindah ke halaman edit
                      },
                      child: Card(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        color: const Color(0xff3b57e6),
                        shadowColor: const Color(0x4d939393),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                              color: Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                pencarianBuku[index].judulBuku,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xffffffff),
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            });
          } else {
            Get.snackbar('Gagal Mencari Data', "Invalid Data Format",
                colorText: Colors.white,
                backgroundColor: Colors.red,
                icon: const Icon(Icons.add_alert));
          }
        } else {
          Get.snackbar(
            'Gagal mencari',
            "Error ${response.reasonPhrase}",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert),
          );
        }
      } catch (e) {
        if (e
            .toString()
            .contains("Connection closed before full header was received")) {
          // Handle the specific error condition here
          // You can add custom handling logic for this case
          Get.snackbar(
            'Gagal meload data',
            "Error:{$e} Connection closed before full header was received",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert),
          );
        }
        throw e;
      }
    }
  }

  void ambilData() async {
    setState(() {
      listBuku = const Center(
        child: CircularProgressIndicator(),
      );
    });
    try {
      final response =
          await http.get(Uri.parse(ConfigApps.url + ConfigApps.listBuku));
      if (response.statusCode == 200) {
        final databuku = dataBukuFromJson(response.body);
        if (mounted) {
          setState(() {
            pencarianBuku = databuku;
            if (databuku.isEmpty) {
              Get.snackbar("Kosong", "tidak ada data",
                  backgroundColor: Colors.red);
            } else {
              listBuku = ListView.builder(
                itemCount: databuku.length,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      //Aksi klik pindah ke halaman edit
                    },
                    child: Card(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      color: const Color(0xff3b57e6),
                      shadowColor: const Color(0x4d939393),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                            color: Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              pencarianBuku[index].judulBuku,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xffffffff),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffffffff),
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          });
        } else {
          Get.snackbar('Gagal Mencari Data', "Invalid Data Format",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              icon: const Icon(Icons.add_alert));
        }
      } else {
        Get.snackbar(
          'Gagal mencari',
          "Error ${response.reasonPhrase}",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    } catch (e) {
      if (e
          .toString()
          .contains("Connection closed before full header was received")) {
        // Handle the specific error condition here
        // You can add custom handling logic for this case
        Get.snackbar(
          'Gagal meload data',
          "Error:{$e} Connection closed before full header was received",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(236, 79, 62, 225),
        title: const Text(
          "Daftar Buku",
          style: TextStyle(color: Color(0xffffffff)),
        ),
        actions: [
          const Icon(
            Icons.add,
            color: Color(0xffffffff),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                child: TextField(
                  controller: textPencarian,
                  scrollPadding: const EdgeInsets.all(10),
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  onSubmitted: (String value){
                    String query = textPencarian.text;
                    cariData(query);
                  },
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:
                          const BorderSide(color: Color(0xffa9aec3), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:
                          const BorderSide(color: Color(0xffa9aec3), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:
                          const BorderSide(color: Color(0xffa9aec3), width: 1),
                    ),
                    hintText: "Pencarian",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xffabb0c4),
                    ),
                    filled: true,
                    fillColor: const Color(0xfff2f4f7),
                    isDense: false,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 24,
                      ),
                      onPressed: () {
                        //Aksi saat icon search di klik'
                        String query = textPencarian.text;
                        cariData(query);
                      },
                      color: const Color(0xffa9aec2),
                    ),
                  ),
                ),
              ),
              listBuku
            ],
          ),
        ),
      ),
    );
  }
}
