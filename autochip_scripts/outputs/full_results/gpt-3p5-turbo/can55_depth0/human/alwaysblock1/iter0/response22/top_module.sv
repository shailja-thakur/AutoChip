module top_module(
  input a, 
  input b,
  output out_assign,
  output reg out_alwaysblock
);
  
  assign out_assign = a & b;  // Using assign statement to implement AND gate
  
  always @(*) begin  // Using combinational always block to implement AND gate
    out_alwaysblock = a & b;
  end

endmodule
