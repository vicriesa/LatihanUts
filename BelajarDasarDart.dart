import 'dart:io';

// =====================================================
// BELAJAR DART DASAR DALAM SATU FILE
// =====================================================
// File ini dibuat untuk mempermudah belajar konsep:
// - void
// - while loop
// - switch
// - fungsi
// - main()
// - program menu sederhana
// =====================================================

void main() {
  print('================================================');
  print('      BELAJAR DART DASAR DALAM SATU FILE        ');
  print('================================================');
  print('');
  print('1. Mengenal void');
  print('2. Mengenal while loop');
  print('3. Mengenal switch');
  print('4. Contoh menu aplikasi');
  print('5. Keluar');

  var jalan = true;

  while (jalan) {
    final pilihan = bacaInput('Pilih menu: ');

    switch (pilihan) {
      case '1':
        contohVoid();
        break;
      case '2':
        contohWhile();
        break;
      case '3':
        contohSwitch();
        break;
      case '4':
        contohMenuAplikasi();
        break;
      case '5':
        jalan = false;
        print('\nProgram selesai. Terima kasih!');
        break;
      default:
        print('\nPilihan tidak tersedia.');
    }
  }
}

// -----------------------------------------------------
// 1. void artinya apa?
// -----------------------------------------------------
// void = fungsi tidak mengembalikan nilai.
// Artinya fungsi hanya menjalankan aksi, tidak memberi hasil balik.
void contohVoid() {
  print('\n--- Contoh void ---');
  print('Fungsi ini hanya menampilkan teks.');
  print('Tidak ada return berupa angka atau string.');
}

// -----------------------------------------------------
// 2. while loop
// -----------------------------------------------------
// while artinya: lakukan sesuatu selama kondisi masih benar.
void contohWhile() {
  print('\n--- Contoh while loop ---');

  var i = 0;

  while (i < 5) {
    print('Iterasi ke-$i');
    i++;
  }

  print('Loop selesai.');
}

// -----------------------------------------------------
// 3. switch
// -----------------------------------------------------
// switch digunakan untuk memilih salah satu kondisi dari banyak pilihan.
void contohSwitch() {
  print('\n--- Contoh switch ---');

  final hari = '2';

  switch (hari) {
    case '1':
      print('Senin');
      break;
    case '2':
      print('Selasa');
      break;
    case '3':
      print('Rabu');
      break;
    default:
      print('Hari tidak diketahui');
  }
}

// -----------------------------------------------------
// 4. Contoh menu aplikasi
// -----------------------------------------------------
// Program menu seperti ini sering dipakai pada aplikasi sederhana.
void contohMenuAplikasi() {
  print('\n--- Contoh Menu Aplikasi ---');
  print('1. Tambah data');
  print('2. Lihat data');
  print('3. Keluar');

  final pilihan = bacaInput('Masukkan pilihan: ');

  switch (pilihan) {
    case '1':
      print('User memilih tambah data');
      break;
    case '2':
      print('User memilih lihat data');
      break;
    case '3':
      print('User memilih keluar');
      break;
    default:
      print('Pilihan salah');
  }
}

// -----------------------------------------------------
// Fungsi untuk membaca input dari user
// -----------------------------------------------------
String bacaInput(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync()?.trim() ?? '';
}

// =====================================================
// RINGKASAN PENTING
// =====================================================
// 1. main() = titik masuk program.
// 2. void = fungsi tanpa return.
// 3. while = perulangan berdasarkan kondisi.
// 4. switch = pemilihan menu atau kondisi.
// 5. Program menu biasanya memakai while + switch.
// =====================================================
// CONTOH PENGGUNAAN SATU FILE PROGRAM MENU:
// while (jalan) {
//   tampilMenu();
//   pilihan = bacaInput('Pilih menu: ');
//   switch (pilihan) {
//     case '1':
//       ...
//       break;
//     case '5':
//       jalan = false;
//       break;
//   }
// }
// =====================================================
