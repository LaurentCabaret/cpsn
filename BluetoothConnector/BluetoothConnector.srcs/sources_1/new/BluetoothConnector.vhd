library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BluetoothConnector is
    PORT ( 
        Rx      : in STD_LOGIC;
        Clk     : in STD_LOGIC;
        LEDS    : out STD_LOGIC_VECTOR (7 downto 0)
    );
end BluetoothConnector;

architecture Behavioral of BluetoothConnector is

COMPONENT RxSystem
    PORT (
       Rx :        in STD_LOGIC;
       Clk :       in STD_LOGIC;
       Data :      out STD_LOGIC_VECTOR (7 downto 0);
       DataRdy :   out STD_LOGIC
   );
END COMPONENT;

SIGNAL Data : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL DataRdy : STD_LOGIC := '1';

begin

RxConnector : RxSystem PORT MAP (
    Rx         => Rx,
    Clk        => Clk,
    Data       => Data,
    DataRdy    => DataRdy
);

process(DataRdy)
begin
    if DataRdy'event and DataRdy = '1' then
        LEDS <= "00000000";
        case Data is
            when "01100110" =>
                -- X is pushed
                LEDS(0) <= '1';
            when "01100111" =>
                -- O is pushed
                LEDS(1) <= '1';
            when others =>
                LEDS <= "00000000";
        end case;
    end if;
end process;

end Behavioral;
