module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Generate the out_assign signal using an assign statement
	assign out_assign = a & b;

	// Generate the out_alwaysblock signal using an always block
	always @(*) begin
		out_alwaysblock = a & b;
	end

endmodule
