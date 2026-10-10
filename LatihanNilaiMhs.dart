import 'dart:io';

void main() {
  // 1. Menggunakan List untuk menyimpan data pendaftar kursus/mahasiswa
  List<Map<String, dynamic>> daftarPendaftar = [
    {'id': 'REG001', 'nama': 'Budi Santoso', 'nilai': 85, 'status': 'Lulus'},
    {'id': 'REG002', 'nama': 'Siti Aminah', 'nilai': 70, 'status': 'Lulus'},
    {'id': 'REG003', 'nama': 'Joko Anwar', 'nilai': 55, 'status': 'Tidak Lulus'},
  ];

  bool isRunning = true;

  print('=== SISTEM PENDAFTARAN & SELEKSI KURSUS ===\n');

  while (isRunning) {
    print('\n--- MENU UTAMA ---');
    print('1. Lihat Semua Data Pendaftar');
    print('2. Tambah Pendaftar Baru');
    print('3. Cek Status Kelulusan Berdasarkan ID');
    print('4. Filter Peserta yang Lulus Saja');
    print('5. Hapus Data Pendaftar');
    print('6. Keluar Program');
    stdout.write('Pilih menu (1-6): ');

    String? input = stdin.readLineSync();
    int pilihan = int.tryParse(input ?? '') ?? 0;

    // 2. Menggunakan switch-case untuk navigasi menu
    switch (pilihan) {
      case 1:
        print('\n=== DAFTAR SEMUA PENDAFTAR ===');
        if (daftarPendaftar.isEmpty) {
          print('Belum ada data pendaftar.');
        } else {
          print('----------------------------------------------------------');
          print('ID      | Nama Lengkap       | Nilai | Status');
          print('----------------------------------------------------------');
          for (var item in daftarPendaftar) {
            print('${item['id']}  | ${item['nama'].padRight(18)} | ${item['nilai'].toString().padRight(5)} | ${item['status']}');
          }
          print('----------------------------------------------------------');
        }
        break;

      case 2:
        print('\n=== TAMBAH PENDAFTAR BARU ===');
        stdout.write('Masukkan ID Pendaftaran (contoh: REG004): ');
        String id = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Nama Lengkap: ');
        String nama = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Nilai Ujian (0-100): ');
        int nilai = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        // Logika otomatis menentukan status berdasarkan nilai (Standar kelulusan: 60)
        String status = (nilai >= 60) ? 'Lulus' : 'Tidak Lulus';

        // Menambahkan data baru ke dalam List
        daftarPendaftar.add({
          'id': id,
          'nama': nama,
          'nilai': nilai,
          'status': status,
        });

        print('Pendaftar berhasil ditambahkan! Status otomatis: $status');
        break;

      case 3:
        print('\n=== CEK STATUS KELULUSAN ===');
        stdout.write('Masukkan ID Pendaftaran yang ingin dicari: ');
        String cariId = stdin.readLineSync() ?? '';

        // Mencari data di dalam List menggunakan firstWhere
        var peserta = daftarPendaftar.firstWhere(
          (item) => item['id'] == cariId,
          orElse: () => {},
        );

        if (peserta.isNotEmpty) {
          print('\n--- Detail Peserta ---');
          print('Nama   : ${peserta['nama']}');
          print('Nilai  : ${peserta['nilai']}');
          print('Status : ${peserta['status']}');
        } else {
          print('Pendaftar dengan ID "$cariId" tidak ditemukan!');
        }
        break;

      case 4:
        print('\n=== DAFTAR PESERTA YANG LULUS ===');
        // Menggunakan method .where() untuk menyaring data spesifik
        var pesertaLulus = daftarPendaftar.where(
          (item) => item['status'] == 'Lulus',
        ).toList();

        if (pesertaLulus.isNotEmpty) {
          int nomor = 1;
          for (var item in pesertaLulus) {
            print('$nomor. [${item['id']}] ${item['nama']} (Nilai: ${item['nilai']})');
            nomor++;
          }
        } else {
          print('Belum ada peserta yang lulus.');
        }
        break;

      case 5:
        print('\n=== HAPUS DATA PENDAFTAR ===');
        stdout.write('Masukkan ID Pendaftaran yang ingin dihapus: ');
        String hapusId = stdin.readLineSync() ?? '';

        // Mencari index data berdasarkan ID
        int index = daftarPendaftar.indexWhere((item) => item['id'] == hapusId);

        if (index != -1) {
          var namaTerhapus = daftarPendaftar[index]['nama'];
          // Menghapus data dari List menggunakan .removeAt()
          daftarPendaftar.removeAt(index);
          print('Data peserta "$namaTerhapus" berhasil dihapus.');
        } else {
          print('ID pendaftar tidak ditemukan.');
        }
        break;

      case 6:
        print('\nTerima kasih telah menggunakan program seleksi!');
        isRunning = false;
        break;

      default:
        print('\nPilihan tidak valid. Silakan masukkan angka 1 sampai 6.');
    }
  }
}