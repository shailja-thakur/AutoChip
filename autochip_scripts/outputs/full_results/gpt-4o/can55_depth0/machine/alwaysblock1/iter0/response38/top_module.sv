module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Using assign statement for the first output
	assign out_assign = a & b;

	// Using always block for the second output
	always @(*) begin
		out_alwaysblock = a & b;
	end

endmodule
