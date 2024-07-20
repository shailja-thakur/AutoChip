module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

wire a_OR_b;
wire c_OR_d;

assign a_OR_b = a | b;
assign c_OR_d = c | d;

assign q = a_OR_b & c_OR_d;

endmodule
