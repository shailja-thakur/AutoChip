module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Implement AND gate using assign statement
	assign out_assign = a & b;

	// Implement AND gate using always block
	always @(*) begin
		out_alwaysblock = a & b;
	end

endmodule
