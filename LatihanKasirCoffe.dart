import 'dart:io';

void main() {
  // Daftar semua menu; setiap menu menyimpan id, nama, dan harga.
  List<Map<String, dynamic>> menuKafe = [
    {'id': 1, 'nama': 'Kopi Espresso', 'harga': 18000},
    {'id': 2, 'nama': 'Caffé Latte', 'harga': 25000},
    {'id': 3, 'nama': 'Croissant', 'harga': 20000},
    {'id': 4, 'nama': 'Mie Goreng Special', 'harga': 22000},
  ];

  // Daftar pesanan yang dipilih pelanggan; awalnya masih kosong.
  List<Map<String, dynamic>> keranjang = [];

  // Penanda agar program terus berjalan sampai pelanggan memilih keluar.
  bool isRunning = true;

  print('=== SELAMAT DATANG DI KASIR KAFE SEDERHANA ===\n');

  while (isRunning) {
    print('\n--- MENU UTAMA ---');
    print('1. Lihat Daftar Menu');
    print('2. Tambah Pesanan ke Keranjang');
    print('3. Lihat Keranjang & Total Belanja');
    print('4. Checkout / Bayar');
    print('5. Keluar Program');
    stdout.write('Pilih menu: ');

    // Menyimpan teks yang diketik; bisa null jika tidak ada input.
    String? input = stdin.readLineSync();
    // Mengubah input menjadi angka; gunakan 0 jika input bukan angka.
    int pilihan = int.tryParse(input ?? '') ?? 0;

    // 2. Menggunakan switch-case untuk navigasi menu
    switch (pilihan) {
      case 1:
        print('\n=== DAFTAR MENU KAFE ===');
        // Tampilkan setiap menu satu per satu.
        for (var item in menuKafe) {
          print('${item['id']}. ${item['nama']} - Rp ${item['harga']}');
        }
        break;

      case 2:
        print('\n=== TAMBAH PESANAN ===');
        for (var item in menuKafe) {
          print('${item['id']}. ${item['nama']} - Rp ${item['harga']}');
        }
        stdout.write('Masukkan Nomor Menu yang ingin dipesan: ');
        // Nomor menu yang dimasukkan pelanggan; 0 jika input tidak valid.
        int idMenu = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        // Cari data menu yang ID-nya sama dengan pilihan pelanggan.
        var menuPilihan = menuKafe.firstWhere(
          (item) => item['id'] == idMenu,
          orElse: () => {},
        );

        if (menuPilihan.isNotEmpty) {
          stdout.write('Masukkan Jumlah (Porsi/Cup): ');
          // Banyaknya porsi atau cup yang dipesan; 1 jika input tidak valid.
          int jumlah = int.tryParse(stdin.readLineSync() ?? '') ?? 1;

          // Simpan nama, harga, jumlah, dan hasil perkalian harga ke keranjang.
          keranjang.add({
            'nama': menuPilihan['nama'],
            'harga': menuPilihan['harga'],
            'jumlah': jumlah,
            'subtotal': menuPilihan['harga'] * jumlah,
          });
          print(
            'Berhasil menambahkan ${jumlah}x ${menuPilihan['nama']} ke keranjang!',
          );
        } else {
          print('Menu tidak ditemukan!');
        }
        break;

      case 3:
        print('\n=== ISI KERANJANG BELANJA ===');
        if (keranjang.isEmpty) {
          print('Keranjang Anda masih kosong.');
        } else {
          // Penampung jumlah harga semua pesanan yang ada di keranjang.
          int totalSemua = 0;
          // i adalah posisi pesanan yang sedang dibaca dari keranjang.
          for (int i = 0; i < keranjang.length; i++) {
            // Ambil pesanan pada posisi i.
            var item = keranjang[i];
            print(
              '${i + 1}. ${item['nama']} (${item['jumlah']}x) - Rp ${item['subtotal']}',
            );
            totalSemua += item['subtotal'] as int;
          }
          print('-----------------------------------');
          print('TOTAL SEMENTARA: Rp $totalSemua');
        }
        break;

      case 4:
        if (keranjang.isEmpty) {
          print('\nKeranjang kosong! Silakan pesan menu terlebih dahulu.');
          break;
        }

        // Jumlahkan subtotal seluruh pesanan untuk mendapatkan total pembayaran.
        int totalSemua = keranjang.fold(
          0,
          (sum, item) => sum + (item['subtotal'] as int),
        );
        print('\n=== CHECKOUT & PEMBAYARAN ===');
        print('Total yang harus dibayar: Rp $totalSemua');

        stdout.write('Masukkan jumlah uang tunai: Rp ');
        // Uang yang dibayarkan pelanggan; 0 jika input bukan angka.
        int bayar = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        if (bayar >= totalSemua) {
          // Selisih uang bayar dan total belanja yang dikembalikan ke pelanggan.
          int kembalian = bayar - totalSemua;
          print('Pembayaran berhasil! Kembalian Anda: Rp $kembalian');
          print('Terima kasih telah berbelanja!');
          keranjang.clear(); // Kosongkan keranjang setelah selesai
        } else {
          print('Uang tidak cukup! Transaksi dibatalkan.');
        }
        break;

      case 5:
        print('\nTerima kasih, sampai jumpa!');
        isRunning = false;
        break;

      default:
        print('\nPilihan tidak valid. Silakan masukkan angka 1 sampai 5.');
    }
  }
}
