import 'dart:io';

void main() {
  // Variabel saldo awal akun ATM.
  double saldo = 1000000;

  // PIN yang benar untuk login.
  const String pinBenar = '1234';

  // Menampilkan tampilan awal ATM.
  print('==============================');
  print('       ATM SEDERHANA');
  print('==============================');

  // Variabel untuk menghitung percobaan login dan status login.
  int percobaan = 0;
  bool login = false;

  // Perulangan login dengan maksimal 3 kali kesempatan.
  while (percobaan < 3) {
    stdout.write('Masukkan PIN: ');
    String? pin = stdin.readLineSync();

    // Jika PIN sesuai, login berhasil dan keluar dari loop.
    if (pin == pinBenar) {
      login = true;
      print('\nLogin berhasil!\n');
      break;
    } else {
      // Jika PIN salah, tambahkan percobaan dan tampilkan sisa kesempatan.
      percobaan++;
      print('PIN salah! Percobaan tersisa: ${3 - percobaan}\n');
    }
  }

  // Jika gagal login 3 kali, program berhenti.
  if (!login) {
    print('Kartu diblokir karena terlalu banyak percobaan.');
    return;
  }

  // Variabel untuk menjaga agar program ATM terus berjalan.
  bool berjalan = true;

  // Loop utama menu ATM.
  while (berjalan) {
    // Menampilkan menu pilihan layanan ATM.
    print('==============================');
    print('          MENU ATM');
    print('==============================');
    print('1. Cek Saldo');
    print('2. Tarik Tunai');
    print('3. Setor Tunai');
    print('4. Keluar');
    print('==============================');

    stdout.write('Pilih menu: ');
    String? pilihan = stdin.readLineSync();

    // Menentukan aksi berdasarkan pilihan menu.
    switch (pilihan) {
      case '1':
        // Menu 1: menampilkan saldo saat ini.
        print('\nSaldo Anda: Rp ${saldo.toStringAsFixed(0)}\n');
        break;

      case '2':
        // Menu 2: proses tarik tunai.
        stdout.write('Masukkan jumlah penarikan: Rp ');
        double? jumlah = double.tryParse(stdin.readLineSync() ?? '');

        // Validasi jumlah penarikan.
        if (jumlah == null || jumlah <= 0) {
          print('Jumlah tidak valid.\n');
        } else if (jumlah > saldo) {
          // Jika jumlah tarik lebih besar dari saldo, penarikan ditolak.
          print('Saldo tidak mencukupi.\n');
        } else {
          // Jika valid, saldo berkurang sesuai jumlah yang ditarik.
          saldo -= jumlah;
          print('Penarikan berhasil.');
          print('Saldo Anda sekarang: Rp ${saldo.toStringAsFixed(0)}\n');
        }
        break;

      case '3':
        // Menu 3: proses setor tunai.
        stdout.write('Masukkan jumlah setoran: Rp ');
        double? jumlah = double.tryParse(stdin.readLineSync() ?? '');

        // Validasi jumlah setoran.
        if (jumlah == null || jumlah <= 0) {
          print('Jumlah tidak valid.\n');
        } else {
          // Jika valid, saldo bertambah sesuai jumlah setoran.
          saldo += jumlah;
          print('Setoran berhasil.');
          print('Saldo Anda sekarang: Rp ${saldo.toStringAsFixed(0)}\n');
        }
        break;

      case '4':
        // Menu 4: keluar dari program ATM.
        print('\nTerima kasih telah menggunakan ATM.');
        berjalan = false;
        break;

      default:
        // Jika pilihan tidak ada di menu, tampilkan pesan error.
        print('Pilihan tidak tersedia.\n');
    }
  }
}
