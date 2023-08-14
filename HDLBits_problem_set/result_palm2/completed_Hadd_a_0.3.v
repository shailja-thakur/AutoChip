Sure, here is a half adder in Verilog:

```module half_adder (
    input wire a,
    input wire b,
    output wire cout,
    output wire sum
);

    always @(posedge clk) begin
        if (a & b) begin
            cout <= 1;
        end else begin
            cout <= 0;
        end
        sum <= a + b;
    end

endmodule
```

This module takes two inputs, `a` and `b`, and produces two outputs, `cout` and `sum`. The `cout` output is 1 if the two inputs are both 1, and 0 otherwise. The `sum` output is the sum of the two inputs.

Here is a half adder in VHDL:

```library IEEE;
use IEEE.std_logic_1164.all;

entity half_adder is
    port (
        a : in std_logic;
        b : in std_logic;
        cout : out std_logic;
        sum : out std_logic
    );
end half_adder;

architecture Behavioral of half_adder is
begin
    process (clk) begin
        if rising_edge(clk) then
            if (a and b) then
                cout <= '1';
            else
                cout <= '0';
            end if;
            sum <= a + b;
        end if;
    end process;
end Behavioral;
```

This module is similar to the Verilog module, but it uses VHDL instead. The `a` and `b` inputs are still the same, but the `cout` and `sum` outputs are now of type `std_logic`. The `process` statement is also similar, but it uses VHDL syntax instead of Verilog syntax.