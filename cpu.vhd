library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpu is
    Port (
        clk  : in  STD_LOGIC;
        rst  : in  STD_LOGIC;
        acc  : out STD_LOGIC_VECTOR(3 downto 0)  -- Untuk observasi
    );
end cpu;

architecture Structural of cpu is
    -- Deklarasi Komponen
    component alu is
        Port ( a, b : in  STD_LOGIC_VECTOR(3 downto 0);
               op : in  STD_LOGIC_VECTOR(1 downto 0);
               result : out STD_LOGIC_VECTOR(3 downto 0);
               carry : out STD_LOGIC);
    end component;
    
    component reg_file is
        Port ( clk, rst, wr_en : in  STD_LOGIC;
               addr : in  STD_LOGIC_VECTOR(3 downto 0);
               data_in : in  STD_LOGIC_VECTOR(3 downto 0);
               data_out : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    component program_counter is
        Port ( clk, rst, load : in  STD_LOGIC;
               pc_in : in  STD_LOGIC_VECTOR(11 downto 0);
               pc_out : out STD_LOGIC_VECTOR(11 downto 0));
    end component;
    
    component rom is
        Port ( addr : in  STD_LOGIC_VECTOR(11 downto 0);
               data : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component control_unit is
        Port ( opcode : in  STD_LOGIC_VECTOR(7 downto 0);
               alu_op : out STD_LOGIC_VECTOR(1 downto 0);
               reg_wr : out STD_LOGIC;
               pc_load : out STD_LOGIC;
               imm_data : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    -- Sinyal Internal
    signal pc_out, jump_addr : STD_LOGIC_VECTOR(11 downto 0);
    signal rom_data : STD_LOGIC_VECTOR(7 downto 0);
    signal alu_result, reg_data, imm_val : STD_LOGIC_VECTOR(3 downto 0);
    signal alu_carry, reg_wr_en, pc_load : STD_LOGIC;
    signal alu_operation : STD_LOGIC_VECTOR(1 downto 0);
    signal acc_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    acc <= acc_reg;  -- Output accumulator
    
    -- Instansiasi Komponen
    PC: program_counter port map(
        clk => clk, rst => rst, load => pc_load,
        pc_in => jump_addr, pc_out => pc_out
    );
    
    ROM_Inst: rom port map(addr => pc_out, data => rom_data);
    
    Ctrl: control_unit port map(
        opcode => rom_data,
        alu_op => alu_operation,
        reg_wr => reg_wr_en,
        pc_load => pc_load,
        imm_data => imm_val
    );
    
    RegFile: reg_file port map(
        clk => clk, rst => rst, wr_en => reg_wr_en,
        addr => rom_data(3 downto 0),  -- Gunakan 4 bit rendah sebagai alamat register
        data_in => alu_result,
        data_out => reg_data
    );
    
    ALU_Inst: alu port map(
        a => acc_reg,
        b => reg_data,
        op => alu_operation,
        result => alu_result,
        carry => alu_carry
    );
    
    -- Proses Eksekusi
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                acc_reg <= "0000";
            elsif reg_wr_en = '1' then
                acc_reg <= alu_result;  -- Update accumulator
            end if;
            
            -- Handle jump address
            if pc_load = '1' then
                jump_addr <= "0000" & rom_data(3 downto 0) & imm_val;
            end if;
        end if;
    end process;
end Structural;