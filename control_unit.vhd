library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entitas unit kendali yang mengdecode opcode
entity control_unit is
    Port (
        opcode   : in  STD_LOGIC_VECTOR(7 downto 0);  -- Instruksi 8-bit
        alu_op   : out STD_LOGIC_VECTOR(1 downto 0);  -- Kode operasi ALU
        reg_wr   : out STD_LOGIC;                     -- Sinyal tulis register
        pc_load  : out STD_LOGIC;                     -- Sinyal load PC (untuk jump)
        imm_data : out STD_LOGIC_VECTOR(3 downto 0)   -- Data immediate 4-bit
    );
end control_unit;

architecture Behavioral of control_unit is
begin
    -- Proses dekode opcode
    process(opcode)
    begin
        -- Nilai default
        alu_op   <= "00";  -- Operasi default: add
        reg_wr   <= '0';   -- Default tidak menulis register
        pc_load  <= '0';   -- Default tidak load PC
        imm_data <= opcode(3 downto 0);  -- Ambil 4 bit rendah sebagai data immediate
        
        -- Dekode berdasarkan 4 bit tinggi opcode
        case opcode(7 downto 4) is
            when "1101" => -- LDM (Load Immediate)
                reg_wr <= '1';  -- Aktifkan penulisan register
            when "0110" => -- ADD
                alu_op <= "00"; -- Set operasi ALU ke add
                reg_wr <= '1'; -- Aktifkan penulisan register
            when "0111" => -- SUB
                alu_op <= "01"; -- Set operasi ALU ke sub
                reg_wr <= '1'; -- Aktifkan penulisan register
            when "0001" => -- JCN (Jump Conditional)
                pc_load <= '1'; -- Aktifkan load PC untuk jump
            when others =>
                null;  -- Tidak ada operasi untuk opcode lain
        end case;
    end process;
end Behavioral;
