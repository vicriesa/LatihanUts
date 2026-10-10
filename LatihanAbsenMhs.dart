import 'dart:io';

void main() {
  // Daftar mahasiswa beserta NIM, nama, kehadiran, dan nilai-nilainya.
  List<Map<String, dynamic>> daftarMahasiswa = [
    {
      'nim': 'H1101241001',
      'nama': 'Vicri Esa',
      'kehadiran': 'Hadir',
      'tugas': 85,
      'uts': 80,
      'uas': 90,
    },
    {
      'nim': 'H1101241002',
      'nama': 'Dewi Lestari',
      'kehadiran': 'Hadir',
      'tugas': 75,
      'uts': 70,
      'uas': 80,
    },
    {
      'nim': 'H1101241003',
      'nama': 'Ahmad Fauzi',
      'kehadiran': 'Sakit',
      'tugas': 60,
      'uts': 65,
      'uas': 60,
    },
  ];

  // Penanda agar menu terus berjalan sampai pengguna memilih keluar.
  bool isRunning = true;

  print('=== SISTEM MANAJEMEN AKADEMIK MAHASISWA ===\n');

  while (isRunning) {
    print('\n--- MENU AKADEMIK ---');
    print('1. Lihat Rekap Data & Nilai Mahasiswa');
    print('2. Tambah Mahasiswa Baru');
    print('3. Catat / Ubah Status Kehadiran');
    print('4. Input / Update Nilai Ujian (Tugas, UTS, UAS)');
    print('5. Hitung Nilai Akhir & Huruf Mutu');
    print('6. Keluar Program');
    stdout.write('Pilih menu (1-6): ');

    // Teks pilihan menu dari pengguna; bisa null jika tidak ada input.
    String? input = stdin.readLineSync();
    // Ubah input menjadi angka; gunakan 0 jika input bukan angka.
    int pilihan = int.tryParse(input ?? '') ?? 0;

    // 2. Menggunakan switch-case untuk navigasi menu utama
    switch (pilihan) {
      case 1:
        print('\n=== REKAP DATA MAHASISWA ===');
        if (daftarMahasiswa.isEmpty) {
          print('Belum ada data mahasiswa.');
        } else {
          print(
            '--------------------------------------------------------------------------------',
          );
          print(
            'NIM         | Nama Lengkap       | Kehadiran | Tugas | UTS | UAS',
          );
          print(
            '--------------------------------------------------------------------------------',
          );
          // Tampilkan data setiap mahasiswa yang terdaftar.
          for (var mhs in daftarMahasiswa) {
            print(
              '${mhs['nim']} | ${mhs['nama'].toString().padRight(18)} | ${mhs['kehadiran'].toString().padRight(9)} | ${mhs['tugas'].toString().padRight(5)} | ${mhs['uts'].toString().padRight(3)} | ${mhs['uas']}',
            );
          }
          print(
            '--------------------------------------------------------------------------------',
          );
        }
        break;

      case 2:
        print('\n=== TAMBAH MAHASISWA BARU ===');
        stdout.write('Masukkan NIM: ');
        // Nomor Induk Mahasiswa yang akan didaftarkan.
        String nim = stdin.readLineSync() ?? '';

        stdout.write('Masukkan Nama Lengkap: ');
        // Nama mahasiswa yang akan didaftarkan.
        String nama = stdin.readLineSync() ?? '';

        // Tambahkan mahasiswa; nilai awal 0 dan status kehadiran 'Hadir'.
        daftarMahasiswa.add({
          'nim': nim,
          'nama': nama,
          'kehadiran': 'Hadir',
          'tugas': 0,
          'uts': 0,
          'uas': 0,
        });

        print('Mahasiswa "$nama" berhasil ditambahkan!');
        break;

      case 3:
        print('\n=== CATAT / UBAH STATUS KEHADIRAN ===');
        stdout.write('Masukkan NIM Mahasiswa: ');
        // NIM mahasiswa yang status kehadirannya akan diubah.
        String cariNim = stdin.readLineSync() ?? '';

        // Data mahasiswa dengan NIM yang cocok; kosong jika tidak ditemukan.
        var mhs = daftarMahasiswa.firstWhere(
          (item) => item['nim'] == cariNim,
          orElse: () => {},
        );

        if (mhs.isNotEmpty) {
          print(
            'Mahasiswa ditemukan: ${mhs['nama']} (Status saat ini: ${mhs['kehadiran']})',
          );
          print('Pilih Status Kehadiran:');
          print('1. Hadir');
          print('2. Izin');
          print('3. Sakit');
          print('4. Alpa');
          stdout.write('Masukkan pilihan (1-4): ');
          // Pilihan status kehadiran; gunakan 1 (Hadir) jika input tidak valid.
          int statusPilihan = int.tryParse(stdin.readLineSync() ?? '') ?? 1;

          // Status baru, ditentukan berdasarkan pilihan pengguna.
          String statusBaru = 'Hadir';
          switch (statusPilihan) {
            case 1:
              statusBaru = 'Hadir';
              break;
            case 2:
              statusBaru = 'Izin';
              break;
            case 3:
              statusBaru = 'Sakit';
              break;
            case 4:
              statusBaru = 'Alpa';
              break;
            default:
              statusBaru = 'Hadir';
          }

          mhs['kehadiran'] = statusBaru;
          print(
            'Kehadiran ${mhs['nama']} berhasil diperbarui menjadi "$statusBaru".',
          );
        } else {
          print('Mahasiswa dengan NIM tersebut tidak ditemukan!');
        }
        break;

      case 4:
        print('\n=== INPUT / UPDATE NILAI UJIAN ===');
        stdout.write('Masukkan NIM Mahasiswa: ');
        // NIM mahasiswa yang nilainya akan diisi atau diperbarui.
        String cariNim = stdin.readLineSync() ?? '';

        // Data mahasiswa dengan NIM yang cocok; kosong jika tidak ditemukan.
        var mhs = daftarMahasiswa.firstWhere(
          (item) => item['nim'] == cariNim,
          orElse: () => {},
        );

        if (mhs.isNotEmpty) {
          print('Mahasiswa: ${mhs['nama']}');
          stdout.write('Masukkan Nilai Tugas (0-100): ');
          // Nilai tugas; jika input tidak valid, gunakan nilai yang tersimpan.
          int tugas = int.tryParse(stdin.readLineSync() ?? '') ?? mhs['tugas'];

          stdout.write('Masukkan Nilai UTS (0-100): ');
          // Nilai UTS; jika input tidak valid, gunakan nilai yang tersimpan.
          int uts = int.tryParse(stdin.readLineSync() ?? '') ?? mhs['uts'];

          stdout.write('Masukkan Nilai UAS (0-100): ');
          // Nilai UAS; jika input tidak valid, gunakan nilai yang tersimpan.
          int uas = int.tryParse(stdin.readLineSync() ?? '') ?? mhs['uas'];

          mhs['tugas'] = tugas;
          mhs['uts'] = uts;
          mhs['uas'] = uas;

          print('Nilai untuk ${mhs['nama']} berhasil diperbarui!');
        } else {
          print('Mahasiswa dengan NIM tersebut tidak ditemukan!');
        }
        break;

      case 5:
        print('\n=== HITUNG NILAI AKHIR & HURUF MUTU ===');
        if (daftarMahasiswa.isEmpty) {
          print('Belum ada data mahasiswa.');
        } else {
          print(
            '----------------------------------------------------------------',
          );
          print('Nama Lengkap       | Nilai Akhir | Huruf Mutu | Keterangan');
          print(
            '----------------------------------------------------------------',
          );
          // Hitung dan tampilkan nilai akhir setiap mahasiswa.
          for (var mhs in daftarMahasiswa) {
            // Nilai akhir memakai bobot tugas 30%, UTS 30%, dan UAS 40%.
            double nilaiAkhir =
                (mhs['tugas'] * 0.3) + (mhs['uts'] * 0.3) + (mhs['uas'] * 0.4);

            // Kedua variabel ini diisi sesuai rentang nilai akhir.
            String hurufMutu;
            String keterangan;

            if (nilaiAkhir >= 85) {
              hurufMutu = 'A';
              keterangan = 'Lulus (Sangat Baik)';
            } else if (nilaiAkhir >= 70) {
              hurufMutu = 'B';
              keterangan = 'Lulus (Baik)';
            } else if (nilaiAkhir >= 55) {
              hurufMutu = 'C';
              keterangan = 'Lulus (Cukup)';
            } else if (nilaiAkhir >= 40) {
              hurufMutu = 'D';
              keterangan = 'Remidi';
            } else {
              hurufMutu = 'E';
              keterangan = 'Tidak Lulus';
            }

            print(
              '${mhs['nama'].toString().padRight(18)} | ${nilaiAkhir.toStringAsFixed(1).padRight(11)} | ${hurufMutu.padRight(10)} | $keterangan',
            );
          }
          print(
            '----------------------------------------------------------------',
          );
        }
        break;

      case 6:
        print('\nKeluar dari program akademik. Sampai jumpa!');
        isRunning = false;
        break;

      default:
        print('\nPilihan tidak valid. Silakan masukkan angka 1 sampai 6.');
    }
  }
}
