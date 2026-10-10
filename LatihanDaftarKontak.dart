import 'dart:io';

void main() {
  // Daftar kontak; setiap kontak menyimpan nama, nomor telepon, dan kategori.
  List<Map<String, String>> daftarKontak = [
    {'nama': 'Budi Santoso', 'telepon': '081234567890', 'kategori': 'Keluarga'},
    {'nama': 'Siti Aminah', 'telepon': '085698765432', 'kategori': 'Teman'},
    {'nama': 'Ahmad Fauzi', 'telepon': '082112233445', 'kategori': 'Kantor'},
  ];

  // Penanda agar menu terus berjalan sampai pengguna memilih keluar.
  bool isRunning = true;

  print('=== APLIKASI BUKU TELEPON / KONTAK ===\n');

  while (isRunning) {
    print('\n--- MENU UTAMA KONTAK ---');
    print('1. Lihat Semua Kontak');
    print('2. Tambah Kontak Baru');
    print('3. Cari Kontak Berdasarkan Nama');
    print('4. Edit Nomor Telepon Kontak');
    print('5. Hapus Kontak');
    print('6. Keluar Program');
    stdout.write('Pilih menu (1-6): ');

    // Teks pilihan menu dari pengguna; bisa null jika tidak ada input.
    String? input = stdin.readLineSync();
    // Ubah input menjadi angka; gunakan 0 jika input bukan angka.
    int pilihan = int.tryParse(input ?? '') ?? 0;

    // 2. Menggunakan switch-case untuk navigasi menu
    switch (pilihan) {
      case 1:
        print('\n=== DAFTAR KONTAK ===');
        if (daftarKontak.isEmpty) {
          print('Belum ada kontak tersimpan.');
        } else {
          print('------------------------------------------------------------');
          print('No | Nama Lengkap       | No. Telepon    | Kategori');
          print('------------------------------------------------------------');
          // i menunjukkan posisi kontak yang sedang ditampilkan.
          for (int i = 0; i < daftarKontak.length; i++) {
            // Ambil data kontak pada posisi i.
            var kontak = daftarKontak[i];
            print(
              '${i + 1}  | ${kontak['nama']!.padRight(18)} | ${kontak['telepon']!.padRight(14)} | ${kontak['kategori']}',
            );
          }
          print('------------------------------------------------------------');
        }
        break;

      case 2:
        print('\n=== TAMBAH KONTAK BARU ===');
        stdout.write('Masukkan Nama Lengkap: ');
        // Nama kontak baru.
        String nama = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Nomor Telepon: ');
        // Nomor telepon kontak baru.
        String telepon = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Kategori (Keluarga/Teman/Kantor/Lainnya): ');
        // Kategori kontak; gunakan 'Lainnya' jika input tidak tersedia.
        String kategori = stdin.readLineSync() ?? 'Lainnya';

        // Simpan kontak baru ke daftar.
        daftarKontak.add({
          'nama': nama,
          'telepon': telepon,
          'kategori': kategori,
        });

        print('Kontak "$nama" berhasil ditambahkan!');
        break;

      case 3:
        print('\n=== CARI KONTAK ===');
        stdout.write('Masukkan nama yang ingin dicari: ');
        // Kata pencarian dibuat huruf kecil agar pencarian tidak membedakan kapital.
        String keyword = (stdin.readLineSync() ?? '').toLowerCase();

        // Daftar kontak yang namanya mengandung kata pencarian.
        var hasilCari = daftarKontak
            .where((kontak) => kontak['nama']!.toLowerCase().contains(keyword))
            .toList();

        if (hasilCari.isNotEmpty) {
          print('\nHasil Pencarian:');
          // Tampilkan setiap kontak yang cocok.
          for (var kontak in hasilCari) {
            print(
              '- Nama: ${kontak['nama']} | Telp: ${kontak['telepon']} | Kategori: ${kontak['kategori']}',
            );
          }
        } else {
          print('Kontak dengan nama tersebut tidak ditemukan.');
        }
        break;

      case 4:
        print('\n=== EDIT NOMOR TELEPON ===');
        stdout.write('Masukkan nama kontak yang ingin diedit: ');
        // Nama kontak yang nomor teleponnya ingin diubah.
        String targetNama = stdin.readLineSync() ?? '';

        // Cari kontak dengan nama yang sama, tanpa membedakan huruf besar/kecil.
        var kontak = daftarKontak.firstWhere(
          (item) => item['nama']!.toLowerCase() == targetNama.toLowerCase(),
          orElse: () => {},
        );

        if (kontak.isNotEmpty) {
          print(
            'Kontak ditemukan: ${kontak['nama']} (No. Telp saat ini: ${kontak['telepon']})',
          );
          stdout.write('Masukkan nomor telepon baru: ');
          // Nomor telepon pengganti.
          String telpBaru = stdin.readLineSync() ?? '';

          // Perbarui nomor telepon pada data kontak yang ditemukan.
          kontak['telepon'] = telpBaru;
          print('Nomor telepon untuk ${kontak['nama']} berhasil diperbarui!');
        } else {
          print('Kontak tidak ditemukan.');
        }
        break;

      case 5:
        print('\n=== HAPUS KONTAK ===');
        stdout.write('Masukkan nama kontak yang ingin dihapus: ');
        // Nama kontak yang akan dihapus.
        String hapusNama = stdin.readLineSync() ?? '';

        // Posisi kontak dengan nama tersebut; -1 berarti tidak ditemukan.
        int index = daftarKontak.indexWhere(
          (item) => item['nama']!.toLowerCase() == hapusNama.toLowerCase(),
        );

        if (index != -1) {
          // Simpan nama sebelum menghapus kontak agar bisa ditampilkan.
          String namaTerhapus = daftarKontak[index]['nama']!;
          // Hapus kontak dari daftar berdasarkan posisinya.
          daftarKontak.removeAt(index);
          print('Kontak "$namaTerhapus" berhasil dihapus dari daftar.');
        } else {
          print('Kontak tidak ditemukan.');
        }
        break;

      case 6:
        print('\nKeluar dari program. Sampai jumpa!');
        isRunning = false;
        break;

      default:
        print('\nPilihan tidak valid. Silakan masukkan angka 1 sampai 6.');
    }
  }
}
