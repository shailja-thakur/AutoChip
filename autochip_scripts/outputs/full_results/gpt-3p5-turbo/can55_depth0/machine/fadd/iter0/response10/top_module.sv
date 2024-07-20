module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

  // Internal wires
  wire carry;
  
  // Calculate sum and carry
  assign sum = (a + b + cin) % 2;
  assign cout = (a + b + cin) >= 2 ? 1'b1 : 1'b0;
  
endmodule
