module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

  // Assign statement to generate out_assign using logical AND operation
  assign out_assign = a & b;
  
  // Always block to generate out_alwaysblock using logical AND operation
  always @(a, b) begin
    out_alwaysblock = a & b;
  end
  
endmodule
