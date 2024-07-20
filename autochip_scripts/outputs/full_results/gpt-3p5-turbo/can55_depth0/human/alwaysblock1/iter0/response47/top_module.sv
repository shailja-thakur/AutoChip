module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// Using Assign Statement
	assign out_assign = a & b;

	// Using Combinational Always Block
	always @*
	begin
		out_alwaysblock = a & b;
	end
	
endmodule
