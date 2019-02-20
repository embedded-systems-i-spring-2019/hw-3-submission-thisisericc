---------------------------------------------------------------------------------- 
-- Engineer: Eric Rivera
-- NET ID: ejr130
-- Create Date: 02/20/2019
-- Project Name: Homework 3
----------------------------------------------------------------------------------

-- EXERCISE #1
----------------------------------------------------------------------------------

-- Library #1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity #1

entity ex1 is
  Port (SEL, CLK, LDA : in std_logic;
        A, B : in std_logic_vector (7 downto 0);
        F: out std_logic_vector (7 downto 0));
end ex1;

-- Architecture #1

architecture my_ex1 of ex1 is
    signal MUX_OUT : std_logic_vector (7 downto 0);
begin

with SEL select 
    MUX_OUT <= A when '1', 
               B when '0', 
               "00000000" when others;
               
RA: process(CLK)

    begin 
    if (rising_edge(CLK)) 
        then if (LDA = '1') then 
            F <= MUX_OUT; 
            end if; 
         end if; 
   end process;
end my_ex1;

-- EXERCISE #2
----------------------------------------------------------------------------------

-- Library #2

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity #2

entity ex2 is 
    Port (DS, CLK : in std_logic;
          X, Y, Z : in std_logic_vector (7 downto 0);
          MS : in std_logic_vector (1 downto 0);
          RA, RB : out std_logic_vector (7 downto 0));
end ex2;

-- Architecture #2

architecture my_ex2 of ex2 is
    signal MUX_OUT : std_logic_vector (7 downto 0);
    signal DEC_OUT: std_logic_vector (1 downto 0);
    signal RBtemp, RAtemp: std_logic_vector (7 downto 0);

begin

with MS select
    MUX_OUT <= X when "11",
               Y when "10",
               Z when "01",
               RBtemp when "00",
               "00000000" when others;

with DS select
    DEC_OUT <= "01" when '0',
               "10" when '1',
               "00" when others;

regA: process (CLK)
begin
    if (CLK'event and CLK = '0') 
        then if (DEC_OUT(0) = '1') then
            RAtemp <= MUX_OUT;
        end if;
    end if;
end process;


regB: process (CLK)
begin
    if (CLK'event and CLK = '0') 
        then if (DEC_OUT(1) = '1') then
            RBtemp <= RAtemp;
        end if;
    end if;
end process;


RB <= Rbtemp;
RA <= RAtemp;

end my_ex2;

-- EXERCISE #3
----------------------------------------------------------------------------------

-- Library #3

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- entity #3

entity ex3 is
    Port (LDA, LDB, CLK, S1, S0: in std_logic;
    X, Y : in std_logic_vector (7 downto 0);
    RB : out std_logic_vector (7 downto 0));
end ex3;

-- architecture #3

architecture my_ex3 of ex3 is
    signal MUX1_OUT, MUX2_OUT: std_logic_vector (7 downto 0);
    signal DEC_OUT: std_logic_vector (1 downto 0);
    signal RBtemp, RA_OUT: std_logic_vector (7 downto 0);

begin

mux1: with S1 select
    MUX1_OUT <= RBtemp when '0',
               X when '1',
               "00000000" when others;

mux2: with S0 select
    MUX2_OUT <= Y when '0',
               RA_OUT when '1',
               "00000000" when others;

regA: process(CLK)

    begin 
    if (rising_edge(CLK)) 
        then if (LDA = '1') then 
            RA_OUT <= MUX1_OUT; 
            end if; 
         end if; 
   end process;


regB: process(CLK)

    begin 
    if (rising_edge(CLK)) 
        then if (LDB = '1') then 
            RBtemp <= MUX2_OUT; 
            end if; 
         end if; 
   end process;

RB <= RBtemp;

end my_ex3;


-- EXERCISE #4
----------------------------------------------------------------------------------


-- Library #4

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- entity #4

entity ex4 is
    Port (LDA, LDB, CLK, RD, S1, S0: in std_logic;
    X, Y : in std_logic_vector (7 downto 0);
    RB, RA : out std_logic_vector (7 downto 0));
end ex4;

-- architecture #4

architecture my_ex4 of ex4 is
    signal MUX1_OUT, MUX2_OUT, RBtemp: std_logic_vector (7 downto 0);
    signal AND1_OUT, AND2_OUT: std_logic;

begin

regA: process(CLK)

    begin 
    if (falling_edge(CLK)) 
        then if (AND2_OUT = '1') then 
            RA <= MUX2_OUT; 
            end if; 
         end if; 
   end process;

regB: process(CLK)

    begin 
    if (falling_edge(CLK)) 
        then if (AND1_OUT = '1') then 
            RBtemp <= MUX1_OUT; 
            end if; 
         end if; 
   end process;

mux1: with S1 select
    MUX1_OUT <= Y when '0',
               X when '1',
               "00000000" when others;

mux2: with S0 select
    MUX2_OUT <= Y when '0',
               RBtemp when '1',
               "00000000" when others;

AND1_OUT <= LDB and (not RD);
AND2_OUT <= LDA and RD;

RB <= RBtemp;

end my_ex4;


-- EXERCISE #5
----------------------------------------------------------------------------------


-- Library #5

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- entity #5

entity ex5 is
    Port (CLK, SL1, SL2: in std_logic;
    A, B, C : in std_logic_vector (7 downto 0);
    RBX, RAX : out std_logic_vector (7 downto 0));
    
end ex5;

-- architecture #5

architecture my_ex5 of ex5 is
    signal DEC_OUT: std_logic_vector(1 downto 0);
    signal MUX_OUT: std_logic_vector(7 downto 0);
begin

regA: process(CLK)

    begin 
    if (rising_edge(CLK)) 
        then if (DEC_OUT(1) = '1') then 
            RAX <= A; 
            end if; 
         end if; 
   end process;

regB: process(CLK)

    begin 
    if (rising_edge(CLK)) 
        then if (DEC_OUT(0) = '1') then 
            RBX <= MUX_OUT; 
            end if; 
         end if; 
   end process;

mux1: with SL2 select
    MUX_OUT <= C when '0',
               B when '1',
               "00000000" when others;

deco: with SL1 select
    DEC_OUT <= "01" when '0',
               "10" when '1',
               "00" when others;
end my_ex5;


-- EXERCISE #6
----------------------------------------------------------------------------------


-- Library #6

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- entity #6

entity ex6 is
    Port (CLK, SEL1, SEL2: in std_logic;
    A, B, C : in std_logic_vector (7 downto 0);
    RBP, RAP : out std_logic_vector (7 downto 0));
    
end ex6;

-- architecture #6

architecture my_ex6 of ex6 is
    signal DEC_OUT: std_logic_vector(1 downto 0);
    signal MUX_OUT: std_logic_vector(7 downto 0);
begin

regA: process(CLK)

    begin 
    if (rising_edge(CLK)) 
        then if (DEC_OUT(1) = '1') then 
            RAP <= MUX_OUT; 
            end if; 
         end if; 
   end process;

regB: process(CLK)

    begin 
    if (rising_edge(CLK)) 
        then if (DEC_OUT(0) = '1') then 
            RBP <= C; 
            end if; 
         end if; 
   end process;

mux1: with SEL1 select
    MUX_OUT <= A when '1',
               B when '0',
               "00000000" when others;

deco: with SEL2 select
    DEC_OUT <= "01" when '0',
               "10" when '1',
               "00" when others;
end my_ex6;