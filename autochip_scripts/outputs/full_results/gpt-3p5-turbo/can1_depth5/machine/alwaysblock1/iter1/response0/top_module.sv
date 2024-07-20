module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

  assign out_assign = a & b; // Logical AND operation using assign statement
  
  always @(a, b) begin
    out_alwaysblock <= a & b; // Logical AND operation using always block
  end
  
endmodule
