library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entitas ROM dengan alamat 12-bit dan data 8-bit
entity rom is
    Port (
        addr : in  STD_LOGIC_VECTOR(11 downto 0);  -- Alamat 12-bit (4096 lokasi)
        data : out STD_LOGIC_VECTOR(7 downto 0)    -- Data output 8-bit
    );
end rom;

architecture Behavioral of rom is
    -- Tipe array untuk ROM 4KB (4096 x 8-bit)
    type rom_array is array (0 to 4095) of STD_LOGIC_VECTOR(7 downto 0);
    
    -- Inisialisasi ROM dengan program contoh
    signal rom_data : rom_array := (
        -- Program contoh:
        --   LDM 5, ADD R1, JCN 0x100
        "11010101",  -- 0: LDM 5 (Opcode D5) - Load immediate value 5 ke accumulator
        "01100001",  -- 1: ADD R1 (Opcode 61) - Tambahkan isi register 1 ke accumulator
        "00010000",  -- 2: JCN 00 (Opcode 10) - Jump conditional (always) ke alamat 0x100
        "00000001",  -- 3: Alamat Lompat (LSB) - Bagian rendah alamat lompat (0x01)
        "00000000",  -- 4: Alamat Lompat (MSB) - Bagian tinggi alamat lompat (0x00)
        others => "00000000"  -- Isi ROM lainnya diinisialisasi dengan 0
    );
begin
    -- Operasi baca ROM asinkron
    data <= rom_data(to_integer(unsigned(addr)));
end Behavioral;
