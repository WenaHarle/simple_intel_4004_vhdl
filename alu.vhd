library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    Port (
        a      : in  STD_LOGIC_VECTOR(3 downto 0);
        b      : in  STD_LOGIC_VECTOR(3 downto 0);
        op     : in  STD_LOGIC_VECTOR(1 downto 0);
        result : out STD_LOGIC_VECTOR(3 downto 0);
        carry  : out STD_LOGIC
    );
end alu;

architecture Behavioral of alu is
    signal res_ext : UNSIGNED(4 downto 0);
begin
    process(a, b, op)
    begin
        case op is
            when "00" => res_ext <= unsigned('0' & a) + unsigned('0' & b);
            when "01" => res_ext <= unsigned('0' & a) - unsigned('0' & b);
            when "10" => res_ext <= unsigned('0' & a);
            when "11" => res_ext <= unsigned('0' & b);
            when others => res_ext <= unsigned('0' & a);
        end case;
    end process;
    
    result <= std_logic_vector(res_ext(3 downto 0));
    carry  <= res_ext(4);
end Behavioral;