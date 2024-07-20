module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Using assign statement for out_assign
	assign out_assign = a & b;

	// Using always block for out_alwaysblock
	always @(a or b) begin
		out_alwaysblock = a & b;
	end

endmodule
