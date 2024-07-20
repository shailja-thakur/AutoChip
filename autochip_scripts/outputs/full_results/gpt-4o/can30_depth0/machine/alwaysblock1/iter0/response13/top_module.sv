module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Assign statement to perform logical AND operation
	assign out_assign = a & b;

	// Always block to perform the same logical AND operation
	always @(*) begin
		out_alwaysblock = a & b;
	end

endmodule
