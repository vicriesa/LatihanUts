import 'dart:collection';
import 'dart:io';

// Menentukan kapasitas maksimal pos pencucian dan waiting list.
const kapasitasPos = 3;
const kapasitasWaitingList = 2;

// Kelas untuk menyimpan data mobil dalam antrian.
class AntrianMobil {
  AntrianMobil({
    required this.nomor,
    required this.namaPelanggan,
    required this.nomorPolisi,
    required this.jenisCuci,
  });

  // Nomor urut antrian mobil.
  final int nomor;

  // Nama pelanggan pemilik mobil.
  final String namaPelanggan;

  // Nomor polisi mobil.
  final String nomorPolisi;

  // Jenis layanan cuci yang dipilih pelanggan.
  final String jenisCuci;
}

void main() {
  // Membuat daftar pos pencucian dengan kapasitas tertentu.
  final posPencucian = List<AntrianMobil?>.filled(kapasitasPos, null);

  // Membuat antrian tunggu untuk mobil yang tidak bisa masuk ke pos.
  final Queue<AntrianMobil> waitingList = Queue<AntrianMobil>();

  // Nomor antrian dimulai dari 1 dan bertambah setiap mobil yang masuk.
  var nomorAntrian = 1;

  // Variabel untuk mengatur program tetap berjalan sampai user memilih keluar.
  var jalan = true;

  // Loop utama program.
  while (jalan) {
    tampilMenu();
    final pilihan = bacaInput('Pilih menu: ');

    switch (pilihan) {
      case '1':
        // Menambah mobil baru ke antrian.
        final berhasil = tambahAntrian(posPencucian, waitingList, nomorAntrian);
        if (berhasil) nomorAntrian++;
        break;
      case '2':
        // Menampilkan status pos dan waiting list.
        tampilkanAntrian(posPencucian, waitingList);
        break;
      case '3':
        // Memanggil mobil yang sudah selesai dicuci.
        panggilMobil(posPencucian, waitingList);
        break;
      case '4':
        // Menghapus isi pos dan waiting list.
        clearAntrian(posPencucian, waitingList);
        break;
      case '5':
        // Keluar dari aplikasi.
        jalan = false;
        print('\nTerima kasih telah menggunakan sistem antrian.');
        break;
      default:
        // Jika pilihan tidak tersedia, tampilkan pesan error.
        print('\nPilihan menu tidak tersedia.');
    }
  }
}

// Menampilkan menu utama aplikasi.
void tampilMenu() {
  print("\n===============================================");
  print("          SISTEM ANTRIAN CUCI MOBIL           ");
  print("===============================================");
  print("1. Tambah antrian mobil");
  print("2. Lihat status pos dan waiting list");
  print("3. Panggil antrian berikutnya");
  print("4. Clear pos/antrian");
  print("5. Keluar Aplikasi");
}

// Fungsi untuk membaca input dari user dan menghapus spasi berlebih.
String bacaInput(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync()?.trim() ?? '';
}

// Menambahkan mobil ke pos kosong atau waiting list bila pos penuh.
bool tambahAntrian(
  List<AntrianMobil?> posPencucian,
  Queue<AntrianMobil> waitingList,
  int nomor,
) {
  print('\n--- Tambah Antrian ---');

  // Membaca data pelanggan dan nomor polisi.
  final namaPelanggan = bacaInput('Nama pelanggan: ');
  final nomorPolisi = bacaInput('Nomor polisi: ');

  // Validasi apakah data wajib sudah diisi.
  if (namaPelanggan.isEmpty || nomorPolisi.isEmpty) {
    print('Nama pelanggan dan nomor polisi wajib diisi.');
    return false;
  }

  // Menampilkan pilihan jenis cuci yang tersedia.
  print('Jenis cuci:');
  print('1. Cuci biasa');
  print('2. Cuci premium');
  print('3. Cuci salju');
  final pilihanCuci = bacaInput('Pilih jenis cuci: ');

  // Mengubah pilihan angka menjadi nama layanan cuci yang jelas.
  final jenisCuci = switch (pilihanCuci) {
    '1' => 'Cuci biasa',
    '2' => 'Cuci premium',
    '3' => 'Cuci salju',
    _ => '',
  };

  // Jika pilihan jenis cuci tidak valid, proses dihentikan.
  if (jenisCuci.isEmpty) {
    print('Jenis cuci tidak tersedia. Data tidak ditambahkan.');
    return false;
  }

  // Membuat objek mobil dari data yang sudah dikumpulkan.
  final mobil = AntrianMobil(
    nomor: nomor,
    namaPelanggan: namaPelanggan,
    nomorPolisi: nomorPolisi.toUpperCase(),
    jenisCuci: jenisCuci,
  );

  // Menyimpan mobil ke pos kosong jika ada slot tersedia.
  final indeksPosKosong = posPencucian.indexWhere((pos) => pos == null);
  if (indeksPosKosong != -1) {
    posPencucian[indeksPosKosong] = mobil;
    print('Mobil masuk ke Pos ${indeksPosKosong + 1} dengan nomor $nomor.');
  }
  // Jika semua pos penuh, mobil masuk waiting list jika masih ada kapasitas.
  else if (waitingList.length < kapasitasWaitingList) {
    waitingList.add(mobil);
    print('Pos penuh. Mobil masuk waiting list dengan nomor $nomor.');
  } else {
    // Jika pos dan waiting list sudah penuh, data tidak ditambahkan.
    print('Pos dan waiting list penuh. Data tidak ditambahkan.');
    return false;
  }

  return true;
}

// Menampilkan status seluruh pos pencucian dan waiting list.
void tampilkanAntrian(
  List<AntrianMobil?> posPencucian,
  Queue<AntrianMobil> waitingList,
) {
  print('\n--- Status Pos Pencucian ---');
  for (var indeks = 0; indeks < posPencucian.length; indeks++) {
    final mobil = posPencucian[indeks];
    if (mobil == null) {
      print('Pos ${indeks + 1}: kosong');
    } else {
      print(
        'Pos ${indeks + 1}: ${mobil.nomor}. ${mobil.namaPelanggan} | '
        '${mobil.nomorPolisi} | ${mobil.jenisCuci}',
      );
    }
  }

  print('\n--- Waiting List ---');
  if (waitingList.isEmpty) {
    print('Waiting list kosong.');
    return;
  }

  for (final mobil in waitingList) {
    print(
      '${mobil.nomor}. ${mobil.namaPelanggan} | '
      '${mobil.nomorPolisi} | ${mobil.jenisCuci}',
    );
  }
}

// Mengambil mobil yang sudah selesai di pos tertentu dan memindahkan mobil waiting list ke pos.
void panggilMobil(
  List<AntrianMobil?> posPencucian,
  Queue<AntrianMobil> waitingList,
) {
  if (posPencucian.every((pos) => pos == null)) {
    print('\nTidak ada mobil di pos pencucian.');
    return;
  }

  // Menampilkan daftar pos yang tersedia untuk dipilih.
  print('\n--- Pilih Pos yang Selesai ---');
  for (var indeks = 0; indeks < posPencucian.length; indeks++) {
    final mobil = posPencucian[indeks];
    print(
      'Pos ${indeks + 1}: '
      '${mobil == null ? 'kosong' : mobil.namaPelanggan}',
    );
  }

  // Membaca nomor pos yang sudah selesai dicuci.
  final pilihanPos = int.tryParse(bacaInput('Masukkan nomor pos: '));
  if (pilihanPos == null || pilihanPos < 1 || pilihanPos > kapasitasPos) {
    print('Nomor pos tidak valid.');
    return;
  }

  final indeksPos = pilihanPos - 1;
  if (posPencucian[indeksPos] == null) {
    print('Pos $pilihanPos sedang kosong.');
    return;
  }

  // Menghapus mobil yang selesai dari pos.
  final mobil = posPencucian[indeksPos]!;
  posPencucian[indeksPos] = null;

  // Menampilkan detail mobil yang dipanggil.
  print('\n--- Panggilan Antrian ---');
  print('Nomor antrian ${mobil.nomor} dipanggil.');
  print('Pelanggan: ${mobil.namaPelanggan}');
  print('Nomor polisi: ${mobil.nomorPolisi}');
  print('Layanan: ${mobil.jenisCuci}');

  // Jika ada mobil di waiting list, pindahkan mobil tersebut ke pos yang kosong.
  if (waitingList.isNotEmpty) {
    final mobilBerikutnya = waitingList.removeFirst();
    posPencucian[indeksPos] = mobilBerikutnya;
    print(
      'Nomor antrian ${mobilBerikutnya.nomor} dari waiting list '
      'masuk ke Pos ${indeksPos + 1}.',
    );
  }
}

// Menghapus semua data di pos dan waiting list bila user memilih clear.
void clearAntrian(
  List<AntrianMobil?> posPencucian,
  Queue<AntrianMobil> waitingList,
) {
  if (posPencucian.every((pos) => pos == null) && waitingList.isEmpty) {
    print('\nPos dan waiting list sudah kosong.');
    return;
  }

  final jumlahDihapus =
      posPencucian.where((pos) => pos != null).length + waitingList.length;

  // Membersihkan semua data dari pos dan waiting list.
  for (var indeks = 0; indeks < posPencucian.length; indeks++) {
    posPencucian[indeks] = null;
  }
  waitingList.clear();
  print('\nBerhasil menghapus $jumlahDihapus mobil dari antrian.');
}
