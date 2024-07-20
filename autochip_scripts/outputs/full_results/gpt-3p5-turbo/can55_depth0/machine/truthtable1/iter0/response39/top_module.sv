module top_module (
	input x3,
	input x2,
	input x1,
	output f
);
  reg f;
  
  always @(*) begin
    f = ( (~x3 & x2 & ~x1) | (~x3 & x2 & x1) | (x3 & ~x2 & x1) | (x3 & x2 & x1) );
  end
  
endmodule
