import 'dart:io';

void main() {
  // Daftar pendaftar; tiap data berisi ID, nama, nilai ujian, dan status.
  List<Map<String, dynamic>> daftarPendaftar = [
    {'id': 'REG001', 'nama': 'Budi Santoso', 'nilai': 85, 'status': 'Lulus'},
    {'id': 'REG002', 'nama': 'Siti Aminah', 'nilai': 70, 'status': 'Lulus'},
    {
      'id': 'REG003',
      'nama': 'Joko Anwar',
      'nilai': 55,
      'status': 'Tidak Lulus',
    },
  ];

  // Penanda agar menu terus berjalan sampai pengguna memilih keluar.
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

    // Teks pilihan menu dari pengguna; bisa null jika tidak ada input.
    String? input = stdin.readLineSync();
    // Ubah input menjadi angka; gunakan 0 jika input bukan angka.
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
          // Tampilkan setiap pendaftar yang tersimpan.
          for (var item in daftarPendaftar) {
            print(
              '${item['id']}  | ${item['nama'].padRight(18)} | ${item['nilai'].toString().padRight(5)} | ${item['status']}',
            );
          }
          print('----------------------------------------------------------');
        }
        break;

      case 2:
        print('\n=== TAMBAH PENDAFTAR BARU ===');
        stdout.write('Masukkan ID Pendaftaran (contoh: REG004): ');
        // ID untuk membedakan pendaftar satu dengan yang lain.
        String id = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Nama Lengkap: ');
        // Nama pendaftar yang akan disimpan.
        String nama = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Nilai Ujian (0-100): ');
        // Nilai ujian; gunakan 0 jika input bukan angka.
        int nilai = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        // Nilai 60 atau lebih dinyatakan lulus.
        String status = (nilai >= 60) ? 'Lulus' : 'Tidak Lulus';

        // Simpan data pendaftar baru ke dalam daftar.
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
        // ID pendaftar yang statusnya ingin diperiksa.
        String cariId = stdin.readLineSync() ?? '';

        // Data pendaftar yang ID-nya cocok; kosong jika tidak ditemukan.
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
        // Daftar baru yang hanya berisi pendaftar dengan status 'Lulus'.
        var pesertaLulus = daftarPendaftar
            .where((item) => item['status'] == 'Lulus')
            .toList();

        if (pesertaLulus.isNotEmpty) {
          // Nomor urut tampilan dimulai dari 1.
          int nomor = 1;
          // Tampilkan setiap peserta yang lulus.
          for (var item in pesertaLulus) {
            print(
              '$nomor. [${item['id']}] ${item['nama']} (Nilai: ${item['nilai']})',
            );
            nomor++;
          }
        } else {
          print('Belum ada peserta yang lulus.');
        }
        break;

      case 5:
        print('\n=== HAPUS DATA PENDAFTAR ===');
        stdout.write('Masukkan ID Pendaftaran yang ingin dihapus: ');
        // ID pendaftar yang datanya ingin dihapus.
        String hapusId = stdin.readLineSync() ?? '';

        // Posisi data dengan ID tersebut; bernilai -1 jika tidak ditemukan.
        int index = daftarPendaftar.indexWhere((item) => item['id'] == hapusId);

        if (index != -1) {
          // Simpan nama agar bisa ditampilkan setelah data dihapus.
          var namaTerhapus = daftarPendaftar[index]['nama'];
          // Hapus data pada posisi yang ditemukan.
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
