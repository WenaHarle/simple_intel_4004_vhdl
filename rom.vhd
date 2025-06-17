library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
    Port (
        addr : in  STD_LOGIC_VECTOR(11 downto 0);
        data : out STD_LOGIC_VECTOR(7 downto 0)
    );
end rom;

architecture Behavioral of rom is
    type rom_array is array (0 to 4095) of STD_LOGIC_VECTOR(7 downto 0);
    signal rom_data : rom_array := (
        -- Program contoh: 
        --   LDM 5, ADD R1, JCN 0x100
        "11010101",  -- 0: LDM 5 (Opcode D5)
        "01100001",  -- 1: ADD R1 (Opcode 61)
        "00010000",  -- 2: JCN 00 (Opcode 10)
        "00000001",  -- 3: Alamat Lompat (LSB)
        "00000000",  -- 4: Alamat Lompat (MSB)
        others => "00000000"
    );
begin
    data <= rom_data(to_integer(unsigned(addr)));
end Behavioral;