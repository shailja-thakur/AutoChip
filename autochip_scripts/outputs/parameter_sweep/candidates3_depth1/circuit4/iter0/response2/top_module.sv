module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal wire
	wire w1, w2, w3;
	
	// Gate-level implementation
	assign w1 = ~ (a | b);
	assign w2 = ~ (c & d);
	assign w3 = ~ (w1 & w2);
	assign q = ~w3;
	
endmodule
