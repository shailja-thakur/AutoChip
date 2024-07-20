module top_module(
	input wire a, 
	input wire b,
	output wire out_assign,
	output reg out_alwaysblock
);

	// AND gate using assign statement
	assign out_assign = a & b;

	// AND gate using always block
	always @(*) begin
		out_alwaysblock = a & b;
	end

endmodule
