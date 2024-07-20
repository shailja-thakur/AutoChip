module top_module(
    input a,
    input b,
    output out_assign,
    output out_alwaysblock
);
  
  assign out_assign = a & b; // Logical AND operation using assign statement
  
  always @(*) begin
    out_alwaysblock = a & b; // Logical AND operation using always block
  end
  
endmodule
