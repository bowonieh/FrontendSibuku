// To parse this JSON data, do
//
//     final dataBuku = dataBukuFromJson(jsonString);

import 'dart:convert';

List<DataBuku> dataBukuFromJson(String str) => List<DataBuku>.from(json.decode(str).map((x) => DataBuku.fromJson(x)));

String dataBukuToJson(List<DataBuku> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataBuku {
    int idBuku;
    String judulBuku;
    String pengarang;
    String penerbit;

    DataBuku({
        required this.idBuku,
        required this.judulBuku,
        required this.pengarang,
        required this.penerbit,
    });

    factory DataBuku.fromJson(Map<String, dynamic> json) => DataBuku(
        idBuku: json["id_buku"],
        judulBuku: json["judul_buku"],
        pengarang: json["pengarang"],
        penerbit: json["penerbit"],
    );

    Map<String, dynamic> toJson() => {
        "id_buku": idBuku,
        "judul_buku": judulBuku,
        "pengarang": pengarang,
        "penerbit": penerbit,
    };
}
