import 'dart:io';

// =====================================================
// BELAJAR DART LANJUTAN DALAM SATU FILE
// =====================================================
// Tujuan:
// - memahami fungsi, return, if, while, for, switch
// - memahami List, Map, dan class
// - memahami pola program menu interaktif
// =====================================================

void main() {
  print('==================================================');
  print('     BELAJAR DART LANJUTAN DALAM SATU FILE      ');
  print('==================================================');
  print('');
  print('1. Fungsi dan return');
  print('2. if / else');
  print('3. switch');
  print('4. while loop');
  print('5. for loop');
  print('6. List');
  print('7. Map');
  print('8. Class');
  print('9. Program menu sederhana');
  print('10. Keluar');

  var jalan = true;

  while (jalan) {
    final pilihan = bacaInput('Pilih menu: ');

    switch (pilihan) {
      case '1':
        contohFungsiDanReturn();
        break;
      case '2':
        contohIfElse();
        break;
      case '3':
        contohSwitch();
        break;
      case '4':
        contohWhile();
        break;
      case '5':
        contohFor();
        break;
      case '6':
        contohList();
        break;
      case '7':
        contohMap();
        break;
      case '8':
        contohClass();
        break;
      case '9':
        contohProgramMenu();
        break;
      case '10':
        jalan = false;
        print('\nProgram selesai.');
        break;
      default:
        print('\nPilihan tidak valid.');
    }
  }
}

// =====================================================
// 1. FUNGSI DAN RETURN
// =====================================================
// Fungsi dengan return mengembalikan nilai.
int tambah(int a, int b) {
  return a + b;
}

void contohFungsiDanReturn() {
  print('\n--- Fungsi dan return ---');
  final hasil = tambah(5, 3);
  print('Hasil tambah: $hasil');

  // void artinya fungsi tidak mengembalikan nilai.
  print('Ini contoh fungsi void');
}

// =====================================================
// 2. IF / ELSE
// =====================================================
void contohIfElse() {
  print('\n--- if / else ---');

  final nilai = 75;

  if (nilai >= 80) {
    print('Nilai bagus');
  } else if (nilai >= 60) {
    print('Nilai cukup');
  } else {
    print('Nilai kurang');
  }
}

// =====================================================
// 3. SWITCH
// =====================================================
void contohSwitch() {
  print('\n--- switch ---');

  final pilihan = '2';

  switch (pilihan) {
    case '1':
      print('Menu 1 dipilih');
      break;
    case '2':
      print('Menu 2 dipilih');
      break;
    case '3':
      print('Menu 3 dipilih');
      break;
    default:
      print('Pilihan tidak tersedia');
  }
}

// =====================================================
// 4. WHILE LOOP
// =====================================================
void contohWhile() {
  print('\n--- while loop ---');

  var i = 0;
  while (i < 5) {
    print('Iterasi while: $i');
    i++;
  }
}

// =====================================================
// 5. FOR LOOP
// =====================================================
void contohFor() {
  print('\n--- for loop ---');

  for (var i = 0; i < 5; i++) {
    print('Iterasi for: $i');
  }
}

// =====================================================
// 6. LIST
// =====================================================
void contohList() {
  print('\n--- List ---');

  final namaMhs = ['Andi', 'Budi', 'Citra'];

  print('Daftar mahasiswa:');
  for (var i = 0; i < namaMhs.length; i++) {
    print('${i + 1}. ${namaMhs[i]}');
  }

  namaMhs.add('Dewi');
  print('Setelah ditambah: $namaMhs');
}

// =====================================================
// 7. MAP
// =====================================================
void contohMap() {
  print('\n--- Map ---');

  final mahasiswa = {'nama': 'Andi', 'nim': '2023001', 'nilai': 90};

  print('Nama: ${mahasiswa['nama']}');
  print('NIM: ${mahasiswa['nim']}');
  print('Nilai: ${mahasiswa['nilai']}');
}

// =====================================================
// 8. CLASS
// =====================================================
class Mahasiswa {
  Mahasiswa({required this.nama, required this.nim, required this.nilai});

  final String nama;
  final String nim;
  final int nilai;

  void tampil() {
    print('Nama: $nama');
    print('NIM: $nim');
    print('Nilai: $nilai');
  }
}

void contohClass() {
  print('\n--- Class ---');

  final mhs = Mahasiswa(nama: 'Rina', nim: '2023101', nilai: 88);

  mhs.tampil();
}

// =====================================================
// 9. PROGRAM MENU SEDERHANA
// =====================================================
void contohProgramMenu() {
  print('\n--- Program Menu Sederhana ---');

  var lanjut = true;

  while (lanjut) {
    print('');
    print('1. Input nama');
    print('2. Tampilkan nama');
    print('3. Keluar');

    final pilihan = bacaInput('Pilih: ');

    switch (pilihan) {
      case '1':
        final nama = bacaInput('Masukkan nama: ');
        print('Nama berhasil disimpan: $nama');
        break;
      case '2':
        print('Nama yang tersimpan adalah: Andi');
        break;
      case '3':
        lanjut = false;
        print('Keluar dari menu.');
        break;
      default:
        print('Pilihan tidak valid');
    }
  }
}

// =====================================================
// FUNGSI BACA INPUT
// =====================================================
String bacaInput(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync()?.trim() ?? '';
}

// =====================================================
// CATATAN PENTING
// =====================================================
// - main() adalah titik masuk program
// - void artinya fungsi tidak mengembalikan nilai
// - return digunakan untuk mengirimkan hasil dari fungsi
// - if/else untuk keputusan
// - switch untuk banyak pilihan
// - while/for untuk perulangan
// - List untuk kumpulan data
// - Map untuk pasangan key-value
// - Class untuk object/data yang lebih terstruktur
// =====================================================
