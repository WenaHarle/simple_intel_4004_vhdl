library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_counter is
    Port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        pc_in    : in  STD_LOGIC_VECTOR(11 downto 0);
        pc_out   : out STD_LOGIC_VECTOR(11 downto 0);
        load     : in  STD_LOGIC
    );
end program_counter;

architecture Behavioral of program_counter is
    signal pc_reg : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                pc_reg <= (others => '0');
            elsif load = '1' then
                pc_reg <= pc_in;
            else
                pc_reg <= std_logic_vector(unsigned(pc_reg) + 1);
            end if;
        end if;
    end process;
    
    pc_out <= pc_reg;
end Behavioral;