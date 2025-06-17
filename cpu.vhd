library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entitas utama CPU dengan port I/O sederhana
entity cpu is
    Port (
        clk  : in  STD_LOGIC;                     -- Sinyal clock
        rst  : in  STD_LOGIC;                     -- Sinyal reset
        acc  : out STD_LOGIC_VECTOR(3 downto 0)   -- Output accumulator untuk observasi
    );
end cpu;

architecture Structural of cpu is
    -- Deklarasi komponen-komponen CPU
    component alu is ... end component;
    component reg_file is ... end component;
    component program_counter is ... end component;
    component rom is ... end component;
    component control_unit is ... end component;
    
    -- Sinyal internal CPU
    signal pc_out, jump_addr : STD_LOGIC_VECTOR(11 downto 0);  -- Sinyal PC
    signal rom_data : STD_LOGIC_VECTOR(7 downto 0);            -- Data dari ROM
    signal alu_result, reg_data, imm_val : STD_LOGIC_VECTOR(3 downto 0);  -- Data path
    signal alu_carry, reg_wr_en, pc_load : STD_LOGIC;          -- Sinyal kontrol
    signal alu_operation : STD_LOGIC_VECTOR(1 downto 0);       -- Operasi ALU
    signal acc_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";   -- Register accumulator
begin
    acc <= acc_reg;  -- Output accumulator
    
    -- Instansiasi komponen Program Counter
    PC: program_counter port map(...);
    
    -- Instansiasi ROM
    ROM_Inst: rom port map(...);
    
    -- Instansiasi Unit Kendali
    Ctrl: control_unit port map(...);
    
    -- Instansiasi Register File
    RegFile: reg_file port map(...);
    
    -- Instansiasi ALU
    ALU_Inst: alu port map(...);
    
    -- Proses eksekusi utama CPU
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then           -- Reset accumulator
                acc_reg <= "0000";
            elsif reg_wr_en = '1' then   -- Update accumulator jika ada penulisan
                acc_reg <= alu_result;
            end if;
            
            -- Handle jump address
            if pc_load = '1' then
                jump_addr <= "0000" & rom_data(3 downto 0) & imm_val;
            end if;
        end if;
    end process;
end Structural;
