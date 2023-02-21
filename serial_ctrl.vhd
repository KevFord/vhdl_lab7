library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity key_ctrl is
port(
    -- Outputs
        serial_on           : in std_logic; -- Pulsed high when x"31"
        serial_off          : in std_logic; -- Pulsed high when x"30"
        serial_up           : in std_logic; -- Pulsed high when x"55" or x"75"
        serial_down         : in std_logic; -- Pulsed high when x"64" or x"44"
    -- Inputs
        clk_50              : in std_logic;
        received_data_valid : in std_logic; -- Pulsed high one clock cycle
        received_data       : in std_logic_vector(7 downto 0) -- An ASCII char
);
end entity;

architecture rtl of key_ctrl is

-- Signals
    signal counter_1_cycle  : integer range 0 to 1 := 0;
    --signal received_data    : std_logic_vector(7 downto 0);
begin

    p_serial_ctrl       : process(clk_50) is
    begin
        if rising_edge(clk_50) then
            case received_data is

                when x"30" =>
                    if counter_1_cycle = 1 then
                        serial_off <= '1';
                        counter_1_cycle <= 0;
                    else 
                        serial_off <= '0';
                        counter_1_cycle <= counter_1_cycle + 1;
                    end if;

                when x"31" =>
                    if counter_1_cycle = 1 then
                        serial_on <= '1';
                        counter_1_cycle <= 0;
                    else 
                        serial_on <= '0';
                        counter_1_cycle <= counter_1_cycle + 1;
                    end if;

                when x"75" or x"55" =>
                    if counter_1_cycle = 1 then
                        serial_up <= '1';
                        counter_1_cycle <= 0;
                    else 
                        serial_up <= '0';
                        counter_1_cycle <= counter_1_cycle + 1;
                    end if;

                when x"64" or x"44" =>
                    if counter_1_cycle = 1 then
                        serial_down <= '1';
                        counter_1_cycle <= 0;
                    else 
                        serial_down <= '0';
                        counter_1_cycle <= counter_1_cycle + 1;
                    end if;
                
                when others =>
                    null; -- Do nothing
            end case;
        end if;
    end p_serial_ctrl;



end architecture;