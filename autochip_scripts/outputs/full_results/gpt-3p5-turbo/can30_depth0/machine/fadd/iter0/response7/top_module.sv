module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	
	// Internal wire
	wire carry_out;
	
	// Logic to calculate carry_out and sum
	assign carry_out = (a + b + cin) >= 2 ? 1'b1 : 1'b0;
	assign sum = (a + b + cin) % 2;
	
	// Assign outputs
	assign cout = carry_out;
	
endmodule
