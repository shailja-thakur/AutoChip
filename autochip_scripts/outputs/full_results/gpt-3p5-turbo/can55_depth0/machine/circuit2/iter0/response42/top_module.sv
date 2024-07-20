module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	reg [3:0] inputs;
	assign inputs = {d, c, b, a};
	assign q = ~(^inputs);
endmodule
