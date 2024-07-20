module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Assign statement for out_assign
	assign out_assign = a & b;

	// Always block for out_alwaysblock
	always @* begin
		out_alwaysblock = a & b;
	end
	
endmodule
