class Area {
  final int idArea;
  final String nameArea;

  Area({required this.idArea, required this.nameArea});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      idArea: json['idArea'],
      nameArea: json['nameArea'],
    );
  }
}
