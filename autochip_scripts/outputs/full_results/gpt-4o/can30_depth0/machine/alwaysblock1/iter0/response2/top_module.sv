module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Using assign statement to generate out_assign
	assign out_assign = a & b;

	// Using always block to generate out_alwaysblock
	always @(*) begin
		out_alwaysblock = a & b;
	end

endmodule
