class Skill{
  final String nama;
  final String kategori;

  Skill({
    required this.nama,
    required this.kategori,
  });

  // Mengubah objek Skill menjadi Map
  Map<String, dynamic> toJson(){
    return{
      'nama': nama,
      'kategori': kategori,
    };
  }

  // <Mengubah Map menjadi objek Skill
  factory Skill.fromJson(Map<String, dynamic> json){
    return Skill(
      nama: json['nama'],
      kategori: json['kategori'],
    );
  }
}