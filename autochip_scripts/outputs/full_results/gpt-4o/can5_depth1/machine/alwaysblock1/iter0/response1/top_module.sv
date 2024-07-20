module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Generate the first output using an assign statement
	assign out_assign = a & b;

	// Always block to generate the second output
	always @(*) begin
		out_alwaysblock = a & b;
	end
	
endmodule
