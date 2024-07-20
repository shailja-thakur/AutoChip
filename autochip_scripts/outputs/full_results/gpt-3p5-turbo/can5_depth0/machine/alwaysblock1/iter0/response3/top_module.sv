module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);
	assign out_assign = a & b;
	
	always @(a or b)
	begin
		out_alwaysblock = a & b;
	end
endmodule
