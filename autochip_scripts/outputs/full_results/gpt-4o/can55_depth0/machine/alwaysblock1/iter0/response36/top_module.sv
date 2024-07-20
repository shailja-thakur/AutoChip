module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Assign the result of the logical AND operation between a and b to out_assign
	assign out_assign = a & b;

	// Always block to assign the logical AND operation result to out_alwaysblock
	always @(a or b) begin
		out_alwaysblock = a & b;
	end

endmodule
