module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [2:0] out_not
);

	assign out_or_bitwise = a | b;
	assign out_or_logical = (a != 3'b0) || (b != 3'b0);
	assign out_not = ~{a, b};

endmodule
