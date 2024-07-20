module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3, w4;

and gate1(w1, a, c);
and gate2(w2, b, c);
or gate3(w3, w1, w2);
not gate4(w4, d);
and gate5(out, w3, w4);

endmodule
module and(
	output wire out, 
	input wire in1,
	input wire in2
);
	assign out = in1 & in2;
endmodule
module or(
	output wire out, 
	input wire in1,
	input wire in2
);
	assign out = in1 | in2;
endmodule
module not(
	output wire out, 
	input wire in
);
	assign out = ~in;
endmodule
