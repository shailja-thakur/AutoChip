module top_module (
	input x3,
	input x2,
	input x1,
	output f
);
	// Intermediate wire
	wire [2:0] input_concat;
	
	// Combine inputs into a single 3-bit vector
	assign input_concat = {x3, x2, x1};
	
	// Use combinational logic to implement the truth table
	assign f = (input_concat == 3'b010) || (input_concat == 3'b011) || (input_concat == 3'b101) || (input_concat == 3'b111);
endmodule
