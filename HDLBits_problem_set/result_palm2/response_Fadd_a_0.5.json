Sure, here is a full adder circuit in Verilog:

```module full_adder (
  input wire a,
  input wire b,
  input wire cin,
  output wire sum,
  output wire cout
);

  assign sum = a + b + cin;
  assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
```

Here is a full adder circuit in VHDL:

```library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
  port (
    a : in std_logic;
    b : in std_logic;
    cin : in std_logic;
    sum : out std_logic;
    cout : out std_logic
  );
end entity full_adder;

architecture Behavioral of full_adder is
  signal carry : std_logic;

begin
  sum <= a + b + cin;
  cout <= carry or (a and b) or (a and cin) or (b and cin);
end architecture Behavioral;
```