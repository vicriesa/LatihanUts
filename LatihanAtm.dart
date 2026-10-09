import 'dart:io';

void main() {
  // Inisialisasi saldo awal ATM dan PIN yang benar.
  double saldo = 1000000;
  const String pinBenar = '1234';

  // Menampilkan header utama aplikasi ATM.
  print('==============================');
  print('       ATM SEDERHANA');
  print('==============================');

  // Variabel untuk mengatur percobaan login dan status login pengguna.
  int percobaan = 0;
  bool login = false;

  // Loop login: pengguna diberi maksimal 3 kali kesempatan memasukkan PIN.
  while (percobaan < 3) {
    stdout.write('Masukkan PIN: ');
    String? pin = stdin.readLineSync();

    // Jika PIN sesuai, login berhasil dan keluar dari loop.
    if (pin == pinBenar) {
      login = true;
      print('\nLogin berhasil!\n');
      break;
    } else {
      // Jika PIN salah, hitung percobaan yang tersisa.
      percobaan++;
      print('PIN salah! Percobaan tersisa: ${3 - percobaan}\n');
    }
  }

  // Jika login gagal setelah 3 kali percobaan, program berhenti.
  if (!login) {
    print('Kartu diblokir karena terlalu banyak percobaan.');
    return;
  }

  // Setelah berhasil login, program masuk ke menu utama ATM.
  bool berjalan = true;

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

    // Switch untuk menjalankan aksi sesuai menu yang dipilih.
    switch (pilihan) {
      case '1':
        // Menu 1: menampilkan saldo saat ini.
        print('\nSaldo Anda: Rp ${saldo.toStringAsFixed(0)}\n');
        break;

      case '2':
        // Menu 2: proses tarik tunai dengan pilihan pecahan.
        print('Pilih pecahan uang:');
        print('1. Rp50.000');
        print('2. Rp100.000');

        stdout.write('Pilih pecahan: ');
        int? pecahan = int.tryParse(stdin.readLineSync() ?? '');

        stdout.write('Masukkan jumlah penarikan: Rp ');
        int? jumlah = int.tryParse(stdin.readLineSync() ?? '');

        // Validasi pecahan dan jumlah penarikan.
        if (pecahan == 1 &&
            jumlah != null &&
            jumlah > 0 &&
            jumlah % 50000 == 0 &&
            jumlah <= saldo) {
          saldo -= jumlah;
          print('Penarikan berhasil.');
          print('Saldo Anda sekarang: Rp ${saldo.toStringAsFixed(0)}\n');
        } else if (pecahan == 2 &&
            jumlah != null &&
            jumlah > 0 &&
            jumlah % 100000 == 0 &&
            jumlah <= saldo) {
          saldo -= jumlah;
          print('Penarikan berhasil.');
          print('Saldo Anda sekarang: Rp ${saldo.toStringAsFixed(0)}\n');
        } else if (jumlah != null && jumlah > saldo) {
          print('Saldo tidak mencukupi.\n');
        } else if (pecahan == null || (pecahan != 1 && pecahan != 2)) {
          print('Pecahan yang dipilih tidak valid.\n');
        } else {
          print(
            'Jumlah tarik tidak valid atau tidak sesuai dengan pecahan yang dipilih.\n',
          );
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
          // Jika jumlah valid, saldo bertambah.
          saldo += jumlah;
          print('Setoran berhasil.');
          print('Saldo Anda sekarang: Rp ${saldo.toStringAsFixed(0)}\n');
        }
        break;

      case '4':
        // Menu 4: keluar dari aplikasi ATM.
        print('\nTerima kasih telah menggunakan ATM.');
        berjalan = false;
        break;

      default:
        // Jika input tidak sesuai menu, tampilkan pesan error.
        print('Pilihan tidak tersedia.\n');
    }
  }
}
