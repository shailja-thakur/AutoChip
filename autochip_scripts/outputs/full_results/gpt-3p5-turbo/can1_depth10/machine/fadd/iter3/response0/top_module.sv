module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

  wire cout_temp;
  assign {cout_temp,sum} = a + b + cin;  // Calculation of cout_temp and sum
  assign cout = cout_temp >= 2 ? 1'b1 : 1'b0;  // Calculation of cout

endmodule
