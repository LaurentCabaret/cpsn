library IEEE ;
use IEEE.STD_LOGIC_1164.ALL;

entity RxFSM is
    Port (
        Clk     : in STD_LOGIC ;
        BdClk   : in STD_LOGIC ;
        Data    : out STD_LOGIC_VECTOR (0 to 7);
        Done    : out STD_LOGIC ;
        BdClkEn : out STD_LOGIC ;
        ClkMod  : out INTEGER range 0 to 3;
        Rx      : in STD_LOGIC
    );
end RxFSM;

architecture Behavioral of RxFSM is

TYPE STATE_TYPE IS (
    Idle , Start , R0 , R1 , R2 , R3 , R4 , R5 , R6 , R7 , Stop , V, I
);

signal state    : STATE_TYPE := Idle;
signal RxClked  : STD_LOGIC ;

begin
    FSMTransition : process ( Clk )
    begin
        if Clk'event and Clk = '1' then
            CASE state IS
                WHEN Idle =>
                    if Rx = '0' then
                        state <= Start ;
                    else
                        state <= Idle ;
                    end if;
                WHEN Start =>
                    if BdClk = '1' then
                        state <= R0;
                    else
                        state <= Start ;
                    end if;
                WHEN R0 =>
                    if BdClk = '1' then
                        state <= R1;
                    else
                        state <= R0;
                    end if;
                WHEN R1 =>
                    if BdClk = '1' then
                        state <= R2;
                    else
                        state <= R1;
                    end if;
                WHEN R2 =>
                    if BdClk = '1' then
                        state <= R3;
                    else
                        state <= R2;
                    end if;
                WHEN R3 =>
                    if BdClk = '1' then
                        state <= R4;
                    else
                        state <= R3;
                    end if;
                WHEN R4 =>
                    if BdClk = '1' then
                        state <= R5;
                    else
                        state <= R4;
                    end if;
                WHEN R5 =>
                    if BdClk = '1' then
                        state <= R6;
                    else
                        state <= R5;
                    end if;
                WHEN R6 =>
                    if BdClk = '1' then
                        state <= R7;
                    else
                        state <= R6;
                    end if;
                WHEN R7 =>
                    if BdClk = '1' then
                        state <= Stop ;
                    else
                        state <= R7;
                    end if;
                WHEN Stop =>
                    if Rx = '0' then
                        state <= I;
                    else
                        state <= V;
                    end if;
                WHEN I =>
                    state <= Idle;
                WHEN V =>
                    state <= Idle;
            END CASE;
        end if;
    end process ;

    FSMValue : process (Clk )
    begin
        if Clk'event and Clk = '1' then
            CASE state IS
                WHEN Idle =>
                    Done <= '1';
                    BdClkEn <= '0';
                    ClkMod <= 0;
                WHEN Start =>
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 3;
                WHEN R0 =>
                    Data(7) <= RxClked;
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 2;
                WHEN R1 =>
                    Data(6) <= RxClked ;
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 2;
                WHEN R2 =>
                    Data(5) <= RxClked;
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 2;
                WHEN R3 =>
                    Data(4) <= RxClked;
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 2;
                WHEN R4 =>
                    Data(3) <= RxClked;
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 2;
                WHEN R5 =>
                    Data(2) <= RxClked ;
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 2;
                WHEN R6 =>
                    Data(1) <= RxClked;
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 2;
                WHEN R7 =>
                    Data(0) <= RxClked ;
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 2;
                WHEN Stop =>
                    Done <= '0';
                    BdClkEn <= '1';
                    ClkMod <= 1;
                WHEN V =>
                    Done <= '1';
                    BdClkEn <= '0';
                    ClkMod <= 0;
                WHEN I =>
                    Done <= '0';
                    BdClkEn <= '0';
                    ClkMod <= 0;
            END CASE;
        end if;
    end process;
    
    EchantillonneRx : process (Clk)
    begin
        if Clk'event and Clk = '1' then
            if BdClk = '1' then
                RxClked <= Rx;
            else
                RxClked <= RxClked;
            end if;
        end if;
    end process;
end Behavioral;
