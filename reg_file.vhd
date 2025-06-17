library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_file is
    Port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        addr     : in  STD_LOGIC_VECTOR(3 downto 0);
        data_in  : in  STD_LOGIC_VECTOR(3 downto 0);
        data_out : out STD_LOGIC_VECTOR(3 downto 0);
        wr_en    : in  STD_LOGIC
    );
end reg_file;

architecture Behavioral of reg_file is
    type reg_array is array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                regs <= (others => (others => '0'));
            elsif wr_en = '1' then
                regs(to_integer(unsigned(addr))) <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= regs(to_integer(unsigned(addr)));
end Behavioral;