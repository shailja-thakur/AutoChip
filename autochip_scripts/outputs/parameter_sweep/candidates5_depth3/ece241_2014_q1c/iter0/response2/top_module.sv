module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate signals
	reg [8:0] sum_reg;
	reg overflow_reg;
	
	// Adder
	always @ (*)
	begin
		sum_reg = a + b;
		
		if (sum_reg[8])
			overflow_reg = 1;
		else
			overflow_reg = 0;
	end
	
	// Output assignments
	assign s = sum_reg[7:0];
	assign overflow = overflow_reg;
	
endmodule
