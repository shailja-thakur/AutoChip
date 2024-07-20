module top_module (
	input a,
	input b,
	input sel,
	output out
);
	always @ (sel)
		if(sel)
			out = b;
		else
			out = a;
endmodule
