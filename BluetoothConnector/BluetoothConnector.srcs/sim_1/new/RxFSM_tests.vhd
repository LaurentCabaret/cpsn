LIBRARY ieee ;
USE ieee . std_logic_1164 . ALL;

ENTITY RxFSM_test IS
END RxFSM_test;

ARCHITECTURE behavior OF RxFSM_test IS
    COMPONENT RxSystem is
    Port (
        Clk : in STD_LOGIC;
        Rx : in STD_LOGIC;
        Data : out STD_LOGIC_VECTOR (7 downto 0) ;
        DataRdy : out STD_LOGIC ;
        BdClk : out STD_LOGIC
    );
    end COMPONENT ;
    
    --Inputs
    signal Clk : STD_LOGIC := '0';
    signal Rx : STD_LOGIC := '1';
    
    --Outputs
    signal Data: STD_LOGIC_VECTOR (7 downto 0);
    signal BdClk : STD_LOGIC ;
    signal DataRdy : STD_LOGIC ;
    
    -- Clock period definitions
    constant Clk_period : time := 10 ns;
    constant BdClk_period : time := 8.8 us;
    
    BEGIN
        uut : RxSystem PORT MAP (
            BdClk => BdClk,
            Data => Data ,
            DataRdy => DataRdy ,
            Clk => Clk ,
            Rx => Rx
        );
    
        -- Clock process definitions
        Clk_process : process
            begin
                Clk <= '0';
                wait for Clk_period / 2;
                Clk <= '1';
                wait for Clk_period / 2;
            end process;
        
        -- Stimulus process
        stim_proc : process
        begin
            -- hold reset state for 100 ns.
            wait for 100 ns;
     
            wait for Clk_period;
            Rx <= '0';
        
            -- insert stimulus here
            wait for BdClk_period ;
            Rx <= '0';
            wait for BdClk_period;
            Rx <= '0';
            wait for BdClk_period ;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '0';
            wait for BdClk_period ;
            Rx <= '0';
            wait for BdClk_period ;
            Rx <= '0';
            wait for BdClk_period ;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '0';

            wait for BdClk_period ;
            Rx <= '1';
                                                 
            wait ;
        end process ;
    END ;
