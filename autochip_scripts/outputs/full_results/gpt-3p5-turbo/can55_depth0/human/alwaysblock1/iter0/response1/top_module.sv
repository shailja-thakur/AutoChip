module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);
  
  // Assign statement implementation
  assign out_assign = a & b;

  // Combinational always block implementation
  always @*
    out_alwaysblock = a & b;

endmodule
