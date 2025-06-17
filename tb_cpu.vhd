library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_cpu is
end tb_cpu;

architecture Behavioral of tb_cpu is
    signal clk, rst : STD_LOGIC := '0';
    signal acc : STD_LOGIC_VECTOR(3 downto 0);
    constant CLK_PERIOD : time := 10 ns;
begin
    -- Instansiasi CPU
    UUT: entity work.cpu
        port map(clk => clk, rst => rst, acc => acc);
    
    -- Generator Clock
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    -- Proses Stimulus
    stim_proc: process
    begin
        rst <= '1';
        wait for CLK_PERIOD;
        rst <= '0';
        
        -- Tunggu eksekusi selesai
        wait for 10*CLK_PERIOD;
        
        -- Verifikasi hasil
        assert acc = "1010"  -- 5 + 5 = 10 (1010 binary)
            report "Test Failed!" severity error;
        
        wait;
    end process;
end Behavioral;