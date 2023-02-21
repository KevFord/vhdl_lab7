-- ////////////////////////////////////////////
-- Key control component for lab 7
-- Author: Kevin Fordal
-- Version 1
--
-- From specifications:
--      "The Key ctrl component shall double synchronize the active low key inputs.
--       The outputs from the compoent shall be set high one clock cycle if the inputs are detected to be low. If
--       the inputs are held low the outputs shall be pulsed high one clock cycle every 10th millisecond.
--       The key_n input vector shall be mapped to the outputs in the following way:
--       key_n(0) shall control key_off output
--       key_n(1) shall control key_on output
--       key_n(2) shall control key_down output
--       key_n(3) shall control key_up output
--       Key_n input bits 3, 2 and 1 shall be ignored if key_n(0) is pushed down.
--       No pulses on key_up or key_down shall be generated if both key_n(2) and key_n(3) is pushed down
--       simultaneously."
--
-- ////////////////////////////////////////////

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity key_ctrl is
port (
    -- Inputs
        clk_50          : in std_logic;
        key_n           : in std_logic_vector(3 downto 0);
        
    -- Outputs
        key_off         : out std_logic; -- key_n(0)
        key_on          : out std_logic; -- key_n(1)
        key_down        : out std_logic; -- key_n(2)
        key_up          : out std_logic  -- key_n(3)
);
end entity key_ctrl;

architecture rtl of key_ctrl is

-- Signals
    signal s_key_n_1r   : std_logic_vector(3 downto 0);
    signal s_key_n_2r   : std_logic_vector(3 downto 0);

    signal s_counter    : integer range 0 to 1;
    -- 1 clock cycle is 20 ns, 5 cycles is 100 ns, 10 ms is 10 000000 ns.
    signal s_count_10ms : integer range 0 to 10000000 - 1;

begin

    -- Debounce inputs
    p_sync_inputs       : process(clk_50) is
    begin
        if rising_edge(clk_50) then
            s_key_n_1r(3 downto 0)  <= key_n(3 downto 0);
            s_key_n_2r(3 downto 0)  <= s_key_n_1r(3 downto 0);
        end if;
    end process p_sync_inputs;

    -- Logic
    p_key_ctrl          : process(clk_50) is
    begin
        if rising_edge(clk_50) then
            --if s_key_n_2r(0) = '1' then -- "key_n 3,2 and 1 shall be ignored if key_n(0) is pushed down."
                case s_key_n_2r is
                    when x"0" =>
                        


                end case;
            --end if;
        end if;

    end process p_key_ctrl;

end architecture;