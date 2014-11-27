library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;

entity RxSystem is
    Port (
        Rx :        in STD_LOGIC;
        Clk :       in STD_LOGIC;
        Data :      out STD_LOGIC_VECTOR (7 downto 0);
        DataRdy :   out STD_LOGIC
    );
end RxSystem;

architecture Behavioral of RxSystem is

COMPONENT ClockGenerator
    PORT (
        MAINCLK :   in STD_LOGIC;
        TRIGGER :   in STD_LOGIC;
        BAUDRATE :  in INTEGER;
        CLKOUT :    out STD_LOGIC
    );
END COMPONENT;

COMPONENT RxFSM
    PORT (
        Clk :       in STD_LOGIC;
        BdClk :     in STD_LOGIC;
        Data :      out STD_LOGIC_VECTOR (7 downto 0);
        Done :      out STD_LOGIC;
        BdClkEn :   out STD_LOGIC;
        ClkMod :    out INTEGER range 0 to 3;
        Rx :        in STD_LOGIC
    ) ; 
END COMPONENT;

signal ClkMod   : INTEGER := 2;
signal BaudRate : INTEGER := 115200;
signal BdClkEn  : STD_LOGIC := '1';
signal BdClkO   : STD_LOGIC := '0';

begin
    with ClkMod select BaudRate <=
        115200 when 0 ,
        230400 when 1 ,
        115200 when 2 ,
        76800 when 3 ,
        76800 when others ;

    ClkGen : ClockGenerator PORT MAP (
        MAINCLK     => Clk,
        TRIGGER     => BdClkEn,
        BAUDRATE    => BaudRate,
        CLKOUT      => BdClkO
    );
    
    RxGenerator : RxFSM PORT MAP (
        Clk         => Clk,
        BdClk       => BdClkO,
        Data        => Data,
        Done        => DataRdy,
        BdClkEn     => BdClkEn,
        ClkMod      => ClkMod,
        Rx          => Rx
    );
   
end Behavioral;