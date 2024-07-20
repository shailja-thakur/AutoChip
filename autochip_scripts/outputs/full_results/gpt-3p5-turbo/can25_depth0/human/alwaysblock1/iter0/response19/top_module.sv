module top_module(
  input a, 
  input b,
  output out_assign,
  output reg out_alwaysblock
);

  // Using assign statement to build an AND gate
  assign out_assign = a & b;

  // Using a combinational always block to build an AND gate
  always @* begin
    out_alwaysblock = a & b;
  end
    
endmodule
