library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entitas ALU 4-bit dengan 4 operasi dasar
entity alu is
    Port (
        a      : in  STD_LOGIC_VECTOR(3 downto 0);  -- Operand A
        b      : in  STD_LOGIC_VECTOR(3 downto 0);  -- Operand B
        op     : in  STD_LOGIC_VECTOR(1 downto 0);  -- Kode operasi (00=add, 01=sub, 10=pass A, 11=pass B)
        result : out STD_LOGIC_VECTOR(3 downto 0);  -- Hasil operasi
        carry  : out STD_LOGIC                      -- Sinyal carry/borrow
    );
end alu;

architecture Behavioral of alu is
    signal res_ext : UNSIGNED(4 downto 0);  -- Hasil extended untuk menangkap carry
begin
    -- Proses kombinasional untuk operasi ALU
    process(a, b, op)
    begin
        case op is
            when "00" => res_ext <= unsigned('0' & a) + unsigned('0' & b);  -- Penjumlahan
            when "01" => res_ext <= unsigned('0' & a) - unsigned('0' & b);  -- Pengurangan
            when "10" => res_ext <= unsigned('0' & a);  -- Pass A
            when "11" => res_ext <= unsigned('0' & b);  -- Pass B
            when others => res_ext <= unsigned('0' & a); -- Default pass A
        end case;
    end process;
    
    -- Output hasil 4-bit dan carry
    result <= std_logic_vector(res_ext(3 downto 0));
    carry  <= res_ext(4);
end Behavioral;
