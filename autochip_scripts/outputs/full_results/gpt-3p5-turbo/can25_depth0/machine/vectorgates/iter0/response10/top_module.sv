module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output reg out_or_logical,
	output [5:0] out_not
);
	
	// Bitwise OR
	assign out_or_bitwise = a | b;
	
	// Logical OR
	always @(*)
	begin
		if (a | b) // If at least one bit is high
			out_or_logical = 1'b1;
		else
			out_or_logical = 1'b0;
	end
	
	// Bitwise NOT
	assign out_not = ~{a,b};
	
endmodule
