import 'dart:io';

void main() {
  // 1. Menggunakan List untuk menyimpan data katalog buku perpustakaan
  List<Map<String, dynamic>> daftarBuku = [
    {'id': 'B001', 'judul': 'Belajar Pemrograman Dart', 'penulis': 'Eko Kurniawan', 'status': 'Tersedia'},
    {'id': 'B002', 'judul': 'Algoritma & Struktur Data', 'penulis': 'Rinaldi Munir', 'status': 'Tersedia'},
    {'id': 'B003', 'judul': 'Flutter Mobile Development', 'penulis': 'Andi Nugroho', 'status': 'Dipinjam'},
  ];

  bool isRunning = true;

  print('=== SISTEM MANAJEMEN PERPUSTAKAAN DIGITAL ===\n');

  while (isRunning) {
    print('\n--- MENU UTAMA PERPUSTAKAAN ---');
    print('1. Lihat Daftar Katalog Buku');
    print('2. Tambah Buku Baru ke Katalog');
    print('3. Pinjam Buku');
    print('4. Kembalikan Buku');
    print('5. Cari Buku Berdasarkan Judul');
    print('6. Keluar Program');
    stdout.write('Pilih menu (1-6): ');

    String? input = stdin.readLineSync();
    int pilihan = int.tryParse(input ?? '') ?? 0;

    // 2. Menggunakan switch-case untuk navigasi menu
    switch (pilihan) {
      case 1:
        print('\n=== DAFTAR KATALOG BUKU ===');
        if (daftarBuku.isEmpty) {
          print('Katalog buku kosong.');
        } else {
          print('----------------------------------------------------------------------');
          print('ID   | Judul Buku                  | Penulis         | Status');
          print('----------------------------------------------------------------------');
          for (var buku in daftarBuku) {
            print('${buku['id']} | ${buku['judul'].toString().padRight(27)} | ${buku['penulis'].toString().padRight(15)} | ${buku['status']}');
          }
          print('----------------------------------------------------------------------');
        }
        break;

      case 2:
        print('\n=== TAMBAH BUKU BARU ===');
        stdout.write('Masukkan ID Buku (contoh: B004): ');
        String id = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Judul Buku: ');
        String judul = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Nama Penulis: ');
        String penulis = stdin.readLineSync() ?? '';

        // Menambahkan buku baru dengan status default 'Tersedia'
        daftarBuku.add({
          'id': id,
          'judul': judul,
          'penulis': penulis,
          'status': 'Tersedia',
        });

        print('Buku "$judul" berhasil ditambahkan ke katalog!');
        break;

      case 3:
        print('\n=== PINJAM BUKU ===');
        stdout.write('Masukkan ID Buku yang ingin dipinjam: ');
        String idPinjam = stdin.readLineSync() ?? '';

        // Cari buku di dalam List menggunakan firstWhere
        var buku = daftarBuku.firstWhere(
          (item) => item['id'] == idPinjam,
          orElse: () => {},
        );

        if (buku.isNotEmpty) {
          if (buku['status'] == 'Tersedia') {
            // Ubah status buku langsung di dalam List
            buku['status'] = 'Dipinjam';
            print('Berhasil! Anda telah meminjam buku "${buku['judul']}".');
          } else {
            print('Maaf, buku "${buku['judul']}" sedang berstatus Dipinjam.');
          }
        } else {
          print('Buku dengan ID tersebut tidak ditemukan!');
        }
        break;

      case 4:
        print('\n=== KEMBALIKAN BUKU ===');
        stdout.write('Masukkan ID Buku yang ingin dikembalikan: ');
        String idKembali = stdin.readLineSync() ?? '';

        var buku = daftarBuku.firstWhere(
          (item) => item['id'] == idKembali,
          orElse: () => {},
        );

        if (buku.isNotEmpty) {
          if (buku['status'] == 'Dipinjam') {
            // Ubah status kembali menjadi Tersedia
            buku['status'] = 'Tersedia';
            print('Terima kasih! Buku "${buku['judul']}" berhasil dikembalikan.');
          } else {
            print('Buku ini tidak sedang dipinjam (status sudah Tersedia).');
          }
        } else {
          print('Buku dengan ID tersebut tidak ditemukan!');
        }
        break;

      case 5:
        print('\n=== PENCARIAN BUKU ===');
        stdout.write('Masukkan kata kunci judul buku: ');
        String keyword = (stdin.readLineSync() ?? '').toLowerCase();

        // Menyaring data buku menggunakan .where()
        var hasilCari = daftarBuku.where(
          (item) => item['judul'].toString().toLowerCase().contains(keyword),
        ).toList();

        if (hasilCari.isNotEmpty) {
          print('\nHasil Pencarian:');
          for (var buku in hasilCari) {
            print('- [${buku['id']}] ${buku['judul']} oleh ${buku['penulis']} (${buku['status']})');
          }
        } else {
          print('Tidak ditemukan buku dengan kata kunci "$keyword".');
        }
        break;

      case 6:
        print('\nKeluar dari program. Terima kasih telah berkunjung!');
        isRunning = false;
        break;

      default:
        print('\nPilihan tidak valid. Silakan masukkan angka 1 sampai 6.');
    }
  }
}