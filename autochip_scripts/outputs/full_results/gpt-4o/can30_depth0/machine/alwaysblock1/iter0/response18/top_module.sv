module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Using an assign statement to perform the logical AND operation
	assign out_assign = a & b;

	// Using an always block to perform the logical AND operation
	always @(*) begin
		out_alwaysblock = a & b;
	end

endmodule
