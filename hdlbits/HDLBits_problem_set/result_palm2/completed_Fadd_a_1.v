Here is a full adder circuit in Verilog:

```module full_adder (
  input wire a,
  input wire b,
  input wire cin,
  output wire cout,
  output wire sum
);

  assign cout = a ^ b ^ cin;
  assign sum = a + b + cin;

endmodule
```

And here is a full adder circuit in VHDL:

```library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    cin : in STD_LOGIC;
    cout : out STD_LOGIC;
    sum : out STD_LOGIC
  );
end entity full_adder;

architecture Behavioral of full_adder is
  begin
    cout <= a xor b xor cin;
    sum <= a + b + cin;
  end architecture Behavioral;
```