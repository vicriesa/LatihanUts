import 'dart:io';

void main() {
  // Daftar buku perpustakaan; setiap buku menyimpan ID, judul, penulis, dan status.
  List<Map<String, dynamic>> daftarBuku = [
    {
      'id': 'B001',
      'judul': 'Belajar Pemrograman Dart',
      'penulis': 'Eko Kurniawan',
      'status': 'Tersedia',
    },
    {
      'id': 'B002',
      'judul': 'Algoritma & Struktur Data',
      'penulis': 'Rinaldi Munir',
      'status': 'Tersedia',
    },
    {
      'id': 'B003',
      'judul': 'Flutter Mobile Development',
      'penulis': 'Andi Nugroho',
      'status': 'Dipinjam',
    },
  ];

  // Penanda agar menu terus berjalan sampai pengguna memilih keluar.
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

    // Teks pilihan yang dimasukkan pengguna; nilainya bisa null.
    String? input = stdin.readLineSync();
    // Ubah input menjadi angka; gunakan 0 jika input bukan angka.
    int pilihan = int.tryParse(input ?? '') ?? 0;

    // 2. Menggunakan switch-case untuk navigasi menu
    switch (pilihan) {
      case 1:
        print('\n=== DAFTAR KATALOG BUKU ===');
        if (daftarBuku.isEmpty) {
          print('Katalog buku kosong.');
        } else {
          print(
            '----------------------------------------------------------------------',
          );
          print(
            'ID   | Judul Buku                  | Penulis         | Status',
          );
          print(
            '----------------------------------------------------------------------',
          );
          // Tampilkan informasi setiap buku yang tersimpan di katalog.
          for (var buku in daftarBuku) {
            print(
              '${buku['id']} | ${buku['judul'].toString().padRight(27)} | ${buku['penulis'].toString().padRight(15)} | ${buku['status']}',
            );
          }
          print(
            '----------------------------------------------------------------------',
          );
        }
        break;

      case 2:
        print('\n=== TAMBAH BUKU BARU ===');
        stdout.write('Masukkan ID Buku (contoh: B004): ');
        // ID untuk membedakan buku ini dari buku lainnya.
        String id = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Judul Buku: ');
        // Judul buku yang akan dimasukkan ke katalog.
        String judul = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Nama Penulis: ');
        // Nama penulis buku tersebut.
        String penulis = stdin.readLineSync() ?? '';

        // Simpan buku baru dengan status awal 'Tersedia'.
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
        // ID buku yang ingin dipinjam pengguna.
        String idPinjam = stdin.readLineSync() ?? '';

        // Data buku dengan ID yang cocok; hasilnya kosong jika tidak ditemukan.
        var buku = daftarBuku.firstWhere(
          (item) => item['id'] == idPinjam,
          orElse: () => {},
        );

        if (buku.isNotEmpty) {
          if (buku['status'] == 'Tersedia') {
            // Tandai buku sebagai sedang dipinjam.
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
        // ID buku yang dikembalikan pengguna.
        String idKembali = stdin.readLineSync() ?? '';

        // Data buku dengan ID yang cocok; hasilnya kosong jika tidak ditemukan.
        var buku = daftarBuku.firstWhere(
          (item) => item['id'] == idKembali,
          orElse: () => {},
        );

        if (buku.isNotEmpty) {
          if (buku['status'] == 'Dipinjam') {
            // Ubah status kembali menjadi Tersedia
            buku['status'] = 'Tersedia';
            print(
              'Terima kasih! Buku "${buku['judul']}" berhasil dikembalikan.',
            );
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
        // Kata pencarian dibuat huruf kecil agar pencarian tidak membedakan huruf besar/kecil.
        String keyword = (stdin.readLineSync() ?? '').toLowerCase();

        // Daftar buku yang judulnya memuat kata kunci tersebut.
        var hasilCari = daftarBuku
            .where(
              (item) =>
                  item['judul'].toString().toLowerCase().contains(keyword),
            )
            .toList();

        if (hasilCari.isNotEmpty) {
          print('\nHasil Pencarian:');
          // Tampilkan semua buku yang cocok dengan kata pencarian.
          for (var buku in hasilCari) {
            print(
              '- [${buku['id']}] ${buku['judul']} oleh ${buku['penulis']} (${buku['status']})',
            );
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
