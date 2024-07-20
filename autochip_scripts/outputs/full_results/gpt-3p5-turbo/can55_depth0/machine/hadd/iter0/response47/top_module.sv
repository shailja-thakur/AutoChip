module top_module (
    input a,
    input b,
    output sum,
    output cout
);
  wire carry;
  assign {cout,sum} = a + b + carry;
endmodule
