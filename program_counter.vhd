library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entitas program counter 12-bit
entity program_counter is
    Port (
        clk      : in  STD_LOGIC;                     -- Sinyal clock
        rst      : in  STD_LOGIC;                     -- Sinyal reset
        pc_in    : in  STD_LOGIC_VECTOR(11 downto 0); -- Input PC untuk jump
        pc_out   : out STD_LOGIC_VECTOR(11 downto 0); -- Output PC
        load     : in  STD_LOGIC                      -- Sinyal load PC
    );
end program_counter;

architecture Behavioral of program_counter is
    signal pc_reg : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');  -- Register PC
begin
    -- Proses sinkron untuk update PC
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then           -- Reset PC ke 0
                pc_reg <= (others => '0');
            elsif load = '1' then       -- Load PC dengan nilai baru (untuk jump)
                pc_reg <= pc_in;
            else                       -- Increment PC normal
                pc_reg <= std_logic_vector(unsigned(pc_reg) + 1);
            end if;
        end if;
    end process;
    
    pc_out <= pc_reg;  -- Output nilai PC
end Behavioral;
