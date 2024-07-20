module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);
	assign out_assign = a &amp; b;
	
	always @* begin
		out_alwaysblock = a &amp; b;
	end
endmodule
