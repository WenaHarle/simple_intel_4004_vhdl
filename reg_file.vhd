library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entitas untuk register file dengan 16 register 4-bit
entity reg_file is
    Port (
        clk      : in  STD_LOGIC;      -- Sinyal clock
        rst      : in  STD_LOGIC;      -- Sinyal reset (active high)
        addr     : in  STD_LOGIC_VECTOR(3 downto 0);  -- Alamat register (0-15)
        data_in  : in  STD_LOGIC_VECTOR(3 downto 0);  -- Data input 4-bit
        data_out : out STD_LOGIC_VECTOR(3 downto 0);  -- Data output 4-bit
        wr_en    : in  STD_LOGIC       -- Enable penulisan register
    );
end reg_file;

architecture Behavioral of reg_file is
    -- Tipe array untuk 16 register 4-bit
    type reg_array is array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
    signal regs : reg_array := (others => (others => '0'));  -- Inisialisasi ke 0
begin
    -- Proses sinkron untuk operasi baca/tulis
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then          -- Reset semua register
                regs <= (others => (others => '0'));
            elsif wr_en = '1' then     -- Tulis data ke register
                regs(to_integer(unsigned(addr))) <= data_in;
            end if;
        end if;
    end process;
    
    -- Output selalu menunjukkan isi register yang dialamati (operasi baca asinkron)
    data_out <= regs(to_integer(unsigned(addr)));
end Behavioral;
