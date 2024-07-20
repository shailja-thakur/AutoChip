module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);
  
  // Using assign statement
  assign out_assign = a & b;

  // Using always block
  always @(*) begin
    out_alwaysblock = a & b;
  end
  
endmodule
