library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entitas testbench untuk verifikasi CPU
entity tb_cpu is
end tb_cpu;

architecture Behavioral of tb_cpu is
    signal clk, rst : STD_LOGIC := '0';       -- Sinyal clock dan reset
    signal acc : STD_LOGIC_VECTOR(3 downto 0); -- Sinyal observasi accumulator
    constant CLK_PERIOD : time := 10 ns;       -- Periode clock 10ns
begin
    -- Instansiasi Unit Under Test (CPU)
    UUT: entity work.cpu
        port map(clk => clk, rst => rst, acc => acc);
    
    -- Proses generator clock
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    -- Proses stimulus testbench
    stim_proc: process
    begin
        rst <= '1';          -- Aktifkan reset
        wait for CLK_PERIOD;
        rst <= '0';          -- Nonaktifkan reset
        
        -- Tunggu eksekusi selesai (10 siklus clock)
        wait for 10*CLK_PERIOD;
        
        -- Verifikasi hasil (5 + 5 = 10 dalam biner 1010)
        assert acc = "1010"  
            report "Test Failed!" severity error;
        
        wait;
    end process;
end Behavioral;
