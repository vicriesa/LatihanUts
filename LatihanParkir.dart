import 'dart:io';

void main() {
  // Daftar kendaraan yang sedang parkir beserta plat, jenis, dan jam masuknya.
  List<Map<String, dynamic>> dataParkir = [
    {'plat': 'KB 1234 AB', 'jenis': 'Mobil', 'jamMasuk': 8},
    {'plat': 'KB 5678 CD', 'jenis': 'Motor', 'jamMasuk': 9},
    {'plat': 'KB 9999 XX', 'jenis': 'Mobil', 'jamMasuk': 10},
  ];

  // Penanda agar menu terus berjalan sampai pengguna memilih keluar.
  bool isRunning = true;

  print('=== SISTEM PARKIR KENDARAAN OTOMATIS ===\n');

  while (isRunning) {
    print('\n--- MENU UTAMA PARKIR ---');
    print('1. Lihat Kendaraan yang Sedang Parkir');
    print('2. Catat Kendaraan Masuk');
    print('3. Catat Kendaraan Keluar & Hitung Biaya');
    print('4. Cari Kendaraan Berdasarkan Plat Nomor');
    print('5. Keluar Program');
    stdout.write('Pilih menu (1-5): ');

    // Teks pilihan menu dari pengguna; bisa null jika tidak ada input.
    String? input = stdin.readLineSync();
    // Ubah pilihan menjadi angka; gunakan 0 jika input bukan angka.
    int pilihan = int.tryParse(input ?? '') ?? 0;

    // 2. Menggunakan switch-case untuk navigasi menu
    switch (pilihan) {
      case 1:
        print('\n=== DAFTAR KENDARAAN DI AREA PARKIR ===');
        if (dataParkir.isEmpty) {
          print('Area parkir saat ini kosong.');
        } else {
          print('--------------------------------------------------');
          print('No | Plat Nomor  | Jenis      | Jam Masuk');
          print('--------------------------------------------------');
          // i menunjukkan posisi kendaraan yang sedang ditampilkan.
          for (int i = 0; i < dataParkir.length; i++) {
            // Ambil data kendaraan pada posisi i.
            var p = dataParkir[i];
            print(
              '${i + 1}  | ${p['plat'].toString().padRight(11)} | ${p['jenis'].toString().padRight(10)} | Jam ${p['jamMasuk']}:00',
            );
          }
          print('--------------------------------------------------');
        }
        break;

      case 2:
        print('\n=== KENDARAAN MASUK ===');
        stdout.write('Masukkan Nomor Plat (contoh: KB 4321 ZZ): ');
        // Simpan plat dalam huruf kapital agar formatnya seragam.
        String plat = (stdin.readLineSync() ?? '').toUpperCase();

        stdout.write('Pilih Jenis Kendaraan (1. Mobil / 2. Motor): ');
        // Nomor pilihan jenis kendaraan; 1 untuk mobil, selain itu motor.
        int jenisPilihan = int.tryParse(stdin.readLineSync() ?? '') ?? 1;
        // Ubah nomor pilihan menjadi nama jenis kendaraan.
        String jenis = (jenisPilihan == 1) ? 'Mobil' : 'Motor';

        stdout.write('Masukkan Jam Masuk (angka 1-24): ');
        // Jam kendaraan mulai parkir; gunakan 0 jika input bukan angka.
        int jamMasuk = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        // Simpan data kendaraan baru ke daftar parkir.
        dataParkir.add({'plat': plat, 'jenis': jenis, 'jamMasuk': jamMasuk});

        print('Kendaraan dengan plat $plat berhasil dicatat masuk.');
        break;

      case 3:
        print('\n=== KENDARAAN KELUAR & PEMBAYARAN ===');
        stdout.write('Masukkan Nomor Plat Kendaraan yang Keluar: ');
        // Plat kendaraan yang akan dicari dan dikeluarkan dari area parkir.
        String cariPlat = (stdin.readLineSync() ?? '').toUpperCase();

        // Posisi kendaraan dengan plat yang cocok; -1 berarti tidak ditemukan.
        int index = dataParkir.indexWhere((item) => item['plat'] == cariPlat);

        if (index != -1) {
          // Ambil data kendaraan yang ditemukan.
          var kendaraan = dataParkir[index];
          // Ambil jam masuk sebagai int untuk perhitungan durasi.
          final int jamMasuk = kendaraan['jamMasuk'] as int;
          stdout.write('Masukkan Jam Keluar saat ini (angka 1-24): ');
          // Jam keluar; jika input bukan angka, gunakan jam masuk.
          int jamKeluar = int.tryParse(stdin.readLineSync() ?? '') ?? jamMasuk;

          // Hitung lama parkir, dengan biaya minimum untuk satu jam.
          int durasi = jamKeluar - jamMasuk;
          if (durasi < 1) durasi = 1; // Minimal hitung 1 jam

          // Tarif per jam: mobil Rp 5.000 dan motor Rp 2.000.
          int tarifPerJam = (kendaraan['jenis'] == 'Mobil') ? 5000 : 2000;
          // Total biaya adalah durasi dikali tarif per jam.
          int totalBiaya = durasi * tarifPerJam;

          print('\n--- STRUK PARKIR ---');
          print('Plat Nomor : ${kendaraan['plat']} (${kendaraan['jenis']})');
          print('Lama Parkir: $durasi jam');
          print('Total Biaya: Rp $totalBiaya');

          // Hapus kendaraan dari daftar setelah selesai parkir.
          dataParkir.removeAt(index);
          print('Kendaraan berhasil dikeluarkan dari sistem.');
        } else {
          print(
            'Kendaraan dengan plat nomor tersebut tidak ditemukan di area parkir.',
          );
        }
        break;

      case 4:
        print('\n=== CARI KENDARAAN ===');
        stdout.write('Masukkan sebagian atau seluruh plat nomor: ');
        // Kata pencarian dibuat kapital agar cocok dengan format plat.
        String keyword = (stdin.readLineSync() ?? '').toUpperCase();

        // Daftar kendaraan dengan plat yang mengandung kata pencarian.
        var hasilCari = dataParkir
            .where((item) => item['plat'].toString().contains(keyword))
            .toList();

        if (hasilCari.isNotEmpty) {
          print('\nHasil Pencarian:');
          // Tampilkan semua kendaraan yang cocok.
          for (var p in hasilCari) {
            print(
              '- [${p['plat']}] ${p['jenis']} (Masuk jam ${p['jamMasuk']}:00)',
            );
          }
        } else {
          print('Tidak ada kendaraan yang cocok.');
        }
        break;

      case 5:
        print('\nKeluar program parkir. Semangat untuk UTS-nya!');
        isRunning = false;
        break;

      default:
        print('\nPilihan tidak valid. Masukkan angka 1 sampai 5.');
    }
  }
}
