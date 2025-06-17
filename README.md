# 💾 Proyek Simulasi Prosesor Intel 4004 dalam VHDL

Proyek ini merupakan simulasi arsitektur prosesor **Intel 4004**, prosesor mikro pertama di dunia, menggunakan bahasa **VHDL**. Tujuan proyek ini adalah untuk memahami dan mereplikasi perilaku dasar dari Intel 4004 dalam bentuk modular yang dapat diuji melalui testbench.

---

## 🧠 Tentang Intel 4004

Intel 4004 adalah prosesor 4-bit pertama yang dikembangkan oleh Intel pada tahun 1971. Prosesor ini memiliki fitur utama sebagai berikut:

- Arsitektur 4-bit
- Register 16 × 4-bit
- ROM 4 KB untuk penyimpanan program
- RAM 640 byte untuk data
- Instruction set sebanyak 46 instruksi
- Memiliki **Program Counter (PC)** 12-bit dan **Instruction Register (IR)**

Intel 4004 mengeksekusi instruksi secara **fetch-decode-execute** dengan bantuan **Control Unit**, dan menggunakan **ALU 4-bit** untuk semua operasi aritmatika dan logika.

Proyek ini mengadopsi sebagian besar struktur arsitektur tersebut dalam desain yang lebih modular dan terbuka.

---

## 🗂️ Struktur File

| File                   | Deskripsi                                                                 |
|------------------------|---------------------------------------------------------------------------|
| `alu.vhd`              | Arithmetic Logic Unit: menangani operasi penjumlahan, logika dasar, dll. |
| `control_unit.vhd`     | Unit kontrol: mendekode instruksi dan menghasilkan sinyal kontrol.        |
| `program_counter.vhd`  | Program Counter: menyimpan dan memperbarui alamat instruksi.             |
| `reg_file.vhd`         | Register File: menyimpan data 4-bit dalam array register.                 |
| `rom.vhd`              | Read-Only Memory: tempat instruksi disimpan dalam bentuk kode mesin.      |
| `cpu.vhd`              | Top-level entitas CPU: mengintegrasikan semua komponen.                   |
| `tb_cpu.vhd`           | Testbench: melakukan simulasi eksekusi instruksi dan verifikasi.          |

---

## 📌 Fitur Prosesor Simulasi

* Arsitektur 4-bit mirip Intel 4004
* Dukungan register umum dan program counter
* Instruksi sederhana:  ADD, JMP, SUB.
* ROM yang dapat diprogram (lihat `rom.vhd`)
* Modular dan mudah dimodifikasi

---

## 🚀 Pengembangan Selanjutnya

* Penambahan RAM eksternal (via port)
* Penambahan decoding instruksi kompleks 4004
* Dukungan interrupt
* Integrasi dengan assembler khusus

