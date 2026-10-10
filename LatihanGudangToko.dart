import 'dart:io';

void main() {
  // Daftar barang di gudang; setiap barang menyimpan kode, nama, stok, dan harga.
  List<Map<String, dynamic>> inventaris = [
    {'kode': 'BRG001', 'nama': 'Buku Tulis', 'stok': 50, 'harga': 5000},
    {'kode': 'BRG002', 'nama': 'Pulpen Hitam', 'stok': 30, 'harga': 3000},
    {'kode': 'BRG003', 'nama': 'Buku Gambar', 'stok': 20, 'harga': 8000},
  ];

  // Penanda agar menu terus ditampilkan sampai pengguna memilih keluar.
  bool isRunning = true;

  print('=== SISTEM MANAJEMEN INVENTARIS GUDANG ===\n');

  while (isRunning) {
    print('\n--- MENU GUDANG ---');
    print('1. Lihat Daftar Stok Barang');
    print('2. Tambah Barang Baru');
    print('3. Catat Barang Masuk (Restock)');
    print('4. Catat Barang Keluar (Terjual/Keluar)');
    print('5. Cari Barang Berdasarkan Nama');
    print('6. Keluar Program');
    stdout.write('Pilih menu (1-6): ');

    // Teks pilihan yang dimasukkan pengguna; bisa null jika tidak ada input.
    String? input = stdin.readLineSync();
    // Ubah input menjadi angka; gunakan 0 jika input bukan angka.
    int pilihan = int.tryParse(input ?? '') ?? 0;

    // 2. Menggunakan switch-case untuk navigasi menu utama
    switch (pilihan) {
      case 1:
        print('\n=== DAFTAR STOK BARANG ===');
        if (inventaris.isEmpty) {
          print('Gudang kosong.');
        } else {
          print('------------------------------------------------------------');
          print('No | Kode    | Nama Barang          | Stok   | Harga');
          print('------------------------------------------------------------');
          // i menunjukkan posisi barang yang sedang ditampilkan.
          for (int i = 0; i < inventaris.length; i++) {
            // Ambil data barang pada posisi i.
            var item = inventaris[i];
            print(
              '${i + 1}  | ${item['kode']} | ${item['nama'].padRight(20)} | ${item['stok'].toString().padRight(6)} | Rp ${item['harga']}',
            );
          }
          print('------------------------------------------------------------');
        }
        break;

      case 2:
        print('\n=== TAMBAH BARANG BARU ===');
        stdout.write('Masukkan Kode Barang (contoh: BRG004): ');
        // Kode unik untuk barang baru.
        String kode = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Nama Barang: ');
        // Nama barang baru yang akan disimpan.
        String nama = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Jumlah Stok Awal: ');
        // Stok awal barang; gunakan 0 jika input bukan angka.
        int stok = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        stdout.write('Masukkan Harga Satuan: Rp ');
        // Harga untuk satu unit barang; gunakan 0 jika input bukan angka.
        int harga = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        // Tambahkan data baru ke dalam List
        inventaris.add({
          'kode': kode,
          'nama': nama,
          'stok': stok,
          'harga': harga,
        });

        print('Sukses! Barang "$nama" berhasil ditambahkan ke gudang.');
        break;

      case 3:
        print('\n=== CATAT BARANG MASUK (RESTOCK) ===');
        stdout.write('Masukkan Kode Barang yang ingin ditambah stoknya: ');
        // Kode barang yang stoknya akan ditambah.
        String cariKode = stdin.readLineSync() ?? '';

        // Data barang yang kodenya cocok; hasilnya kosong jika tidak ditemukan.
        var barang = inventaris.firstWhere(
          (item) => item['kode'] == cariKode,
          orElse: () => {},
        );

        if (barang.isNotEmpty) {
          print(
            'Barang ditemukan: ${barang['nama']} (Stok saat ini: ${barang['stok']})',
          );
          stdout.write('Masukkan jumlah barang masuk: ');
          // Banyaknya barang yang datang untuk menambah stok.
          int tambahan = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

          // Update nilai stok di dalam List
          barang['stok'] += tambahan;
          print(
            'Berhasil! Stok baru ${barang['nama']} sekarang menjadi ${barang['stok']}.',
          );
        } else {
          print('Barang dengan kode tersebut tidak ditemukan!');
        }
        break;

      case 4:
        print('\n=== CATAT BARANG KELUAR ===');
        stdout.write('Masukkan Kode Barang yang keluar: ');
        // Kode barang yang stoknya akan dikurangi.
        String cariKode = stdin.readLineSync() ?? '';

        // Data barang yang kodenya cocok; hasilnya kosong jika tidak ditemukan.
        var barang = inventaris.firstWhere(
          (item) => item['kode'] == cariKode,
          orElse: () => {},
        );

        if (barang.isNotEmpty) {
          print(
            'Barang ditemukan: ${barang['nama']} (Stok saat ini: ${barang['stok']})',
          );
          stdout.write('Masukkan jumlah barang yang keluar: ');
          // Banyaknya barang yang dikeluarkan dari gudang.
          int keluar = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

          if (keluar <= barang['stok']) {
            barang['stok'] -= keluar;
            print(
              'Berhasil! Stok sisa ${barang['nama']} sekarang menjadi ${barang['stok']}.',
            );
          } else {
            print(
              'Gagal! Stok tidak mencukupi (Stok tersedia hanya ${barang['stok']}).',
            );
          }
        } else {
          print('Barang dengan kode tersebut tidak ditemukan!');
        }
        break;

      case 5:
        print('\n=== PENCARIAN BARANG ===');
        stdout.write('Masukkan kata kunci nama barang: ');
        // Kata yang akan dicari pada nama barang; dibuat huruf kecil.
        String keyword = (stdin.readLineSync() ?? '').toLowerCase();

        // Daftar barang yang namanya memuat kata kunci pencarian.
        var hasilCari = inventaris
            .where(
              (item) => item['nama'].toString().toLowerCase().contains(keyword),
            )
            .toList();

        if (hasilCari.isNotEmpty) {
          print('\nHasil Pencarian:');
          // Tampilkan satu per satu barang yang cocok.
          for (var item in hasilCari) {
            print(
              '- [${item['kode']}] ${item['nama']} | Stok: ${item['stok']} | Rp ${item['harga']}',
            );
          }
        } else {
          print('Tidak ditemukan barang dengan nama "$keyword".');
        }
        break;

      case 6:
        print('\nKeluar dari program. Terima kasih!');
        isRunning = false;
        break;

      default:
        print('\nPilihan tidak valid. Masukkan angka 1 sampai 6.');
    }
  }
}
