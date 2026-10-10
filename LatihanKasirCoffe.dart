import 'dart:io';

void main() {
  // 1. Menggunakan List untuk menyimpan data menu produk
  List<Map<String, dynamic>> menuKafe = [
    {'id': 1, 'nama': 'Kopi Espresso', 'harga': 18000},
    {'id': 2, 'nama': 'Caffé Latte', 'harga': 25000},
    {'id': 3, 'nama': 'Croissant', 'harga': 20000},
    {'id': 4, 'nama': 'Mie Goreng Special', 'harga': 22000},
  ];

  // List untuk menampung item yang dibeli (Keranjang)
  List<Map<String, dynamic>> keranjang = [];
  
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
    
    String? input = stdin.readLineSync();
    int pilihan = int.tryParse(input ?? '') ?? 0;

    // 2. Menggunakan switch-case untuk navigasi menu
    switch (pilihan) {
      case 1:
        print('\n=== DAFTAR MENU KAFE ===');
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
        int idMenu = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        // Cari menu berdasarkan ID di dalam List
        var menuPilihan = menuKafe.firstWhere(
          (item) => item['id'] == idMenu,
          orElse: () => {},
        );

        if (menuPilihan.isNotEmpty) {
          stdout.write('Masukkan Jumlah (Porsi/Cup): ');
          int jumlah = int.tryParse(stdin.readLineSync() ?? '') ?? 1;

          // Masukkan ke List keranjang
          keranjang.add({
            'nama': menuPilihan['nama'],
            'harga': menuPilihan['harga'],
            'jumlah': jumlah,
            'subtotal': menuPilihan['harga'] * jumlah,
          });
          print('Berhasil menambahkan ${jumlah}x ${menuPilihan['nama']} ke keranjang!');
        } else {
          print('Menu tidak ditemukan!');
        }
        break;

      case 3:
        print('\n=== ISI KERANJANG BELANJA ===');
        if (keranjang.isEmpty) {
          print('Keranjang Anda masih kosong.');
        } else {
          int totalSemua = 0;
          for (int i = 0; i < keranjang.length; i++) {
            var item = keranjang[i];
            print('${i + 1}. ${item['nama']} (${item['jumlah']}x) - Rp ${item['subtotal']}');
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

        int totalSemua = keranjang.fold(0, (sum, item) => sum + (item['subtotal'] as int));
        print('\n=== CHECKOUT & PEMBAYARAN ===');
        print('Total yang harus dibayar: Rp $totalSemua');
        
        stdout.write('Masukkan jumlah uang tunai: Rp ');
        int bayar = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        if (bayar >= totalSemua) {
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