module top_module(
  input a, 
  input b,
  output out_assign,
  output reg out_alwaysblock
);
  assign out_assign = a & b;  // perform logical AND operation using assign statement
  always @(*) begin  // always block triggered whenever any of the variables in the sensitivity list changes
    out_alwaysblock = a & b;  // perform logical AND operation inside always block and assign the result to out_alwaysblock
  end
endmodule
