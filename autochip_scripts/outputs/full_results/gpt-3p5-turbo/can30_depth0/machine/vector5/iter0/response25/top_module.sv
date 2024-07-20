module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
	assign out = ~(5'b{a}) ^ (5'b{a,b,c,d,e});
endmodule
