Sure, here is a half adder in Verilog:

```module half_adder (
    input wire a,
    input wire b,
    output wire sum,
    output wire carry
);

    assign sum = a ^ b;
    assign carry = a & b;

endmodule
```

This module takes two inputs, `a` and `b`, and produces two outputs, `sum` and `carry`. The `sum` output is the logical OR of `a` and `b`, while the `carry` output is the logical AND of `a` and `b`.

Here is a half adder in VHDL:

```library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    port (
        a : in std_logic;
        b : in std_logic;
        sum : out std_logic;
        carry : out std_logic
    );
end half_adder;

architecture Behavioral of half_adder is
begin
    process (a, b) begin
        sum <= a or b;
        carry <= a and b;
    end process;
end Behavioral;
```

This module takes two inputs, `a` and `b`, and produces two outputs, `sum` and `carry`. The `sum` output is the OR of `a` and `b`, while the `carry` output is the AND of `a` and `b`.