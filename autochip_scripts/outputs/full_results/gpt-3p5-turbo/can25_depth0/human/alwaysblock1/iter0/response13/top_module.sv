module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

  assign out_assign = a & b;  // Assign statement for AND gate
  
  always @(*)
  begin
    out_alwaysblock = a & b;  // Combinational always block for AND gate
  end

endmodule
