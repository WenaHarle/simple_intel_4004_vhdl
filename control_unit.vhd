library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
    Port (
        opcode   : in  STD_LOGIC_VECTOR(7 downto 0);
        alu_op   : out STD_LOGIC_VECTOR(1 downto 0);
        reg_wr   : out STD_LOGIC;
        pc_load  : out STD_LOGIC;
        imm_data : out STD_LOGIC_VECTOR(3 downto 0)
    );
end control_unit;

architecture Behavioral of control_unit is
begin
    process(opcode)
    begin
        -- Default values
        alu_op   <= "00";
        reg_wr   <= '0';
        pc_load  <= '0';
        imm_data <= opcode(3 downto 0);
        
        case opcode(7 downto 4) is
            when "1101" => -- LDM
                reg_wr <= '1';
            when "0110" => -- ADD
                alu_op <= "00";
                reg_wr <= '1';
            when "0111" => -- SUB
                alu_op <= "01";
                reg_wr <= '1';
            when "0001" => -- JCN
                pc_load <= '1';
            when others =>
                null;
        end case;
    end process;
end Behavioral;