LIBRARY ieee ;
USE ieee . std_logic_1164 . ALL;

ENTITY BluetoothConnector_test IS
END BluetoothConnector_test;

ARCHITECTURE behavior OF BluetoothConnector_test IS
    COMPONENT BluetoothConnector is
    PORT (
        Rx : in STD_LOGIC;
        Clk : in STD_LOGIC;
        LEDS : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end COMPONENT ;
    
    --Inputs
    signal Clk : STD_LOGIC := '0';
    signal Rx : STD_LOGIC := '1';
    
    --Outputs
    signal LEDS: STD_LOGIC_VECTOR (7 downto 0);

    -- Clock period definitions
    constant Clk_period : time := 10 ns;
    constant BdClk_period : time := 8.8 us;
    
    BEGIN
        uut : BluetoothConnector PORT MAP (
            Rx      => Rx,
            Clk     => Clk,
            LEDS    => LEDS
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
            Rx <= '1';
            wait for BdClk_period;
            
            -- SEND X SIGNAL
            wait for BdClk_period;
            Rx <= '0';
        
            wait for BdClk_period ;
            Rx <= '0';
            wait for BdClk_period;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '0';
            wait for BdClk_period ;
            Rx <= '0';
            wait for BdClk_period ;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '0';

            wait for BdClk_period ;
            Rx <= '1';
 
            wait for BdClk_period * 3;
                                  
            -- SEND O SIGNAL
            wait for BdClk_period;
            Rx <= '0';
                    
            wait for BdClk_period ;
            Rx <= '1';
            wait for BdClk_period;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '0';
            wait for BdClk_period ;
            Rx <= '0';
            wait for BdClk_period ;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '1';
            wait for BdClk_period ;
            Rx <= '0';
            
            wait for BdClk_period ;
            Rx <= '1';
                        
                                                 
            wait ;
        end process ;
    END ;