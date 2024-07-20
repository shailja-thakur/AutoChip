module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Intermediate wires to hold temporary values during the population count
	wire [2:0] temp;
	
	// Instantiate the population count circuit for each bit in the input vector
	population_count_1bit PC0 (.in(in[0]), .out(temp[0]));
	population_count_1bit PC1 (.in(in[1]), .out(temp[1]));
	population_count_1bit PC2 (.in(in[2]), .out(temp[2]));
	
	// Compute the final population count by summing all the intermediate values
	assign out[1] = temp[0] + temp[1] + temp[2];
	
	// Output the individual population counts for each bit
	assign out[0] = temp[0];
	
endmodule
module population_count_1bit (
	input in,
	output out
);
	assign out = in;
endmodule
