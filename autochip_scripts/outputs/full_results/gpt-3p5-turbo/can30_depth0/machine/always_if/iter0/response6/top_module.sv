module top_module (
	input a,
	input b,
	input sel_b1,
	input sel_b2,
	output out_assign,
	output reg out_always
);

	// using assign statement
	assign out_assign = (sel_b1 & sel_b2) ? b : a;
	
	// using always block to update output
	always @(a, b, sel_b1, sel_b2)
		if (sel_b1 & sel_b2)
			out_always = b;
		else
			out_always = a;
	
endmodule
