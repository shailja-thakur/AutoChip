module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

reg q;

always @(a, b, c, d) begin
  q = (a | b) & (c | d);
end

endmodule
