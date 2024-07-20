module top_module (
	input a,
	input b,
	input sel_b1,
	input sel_b2,
	output out_assign,
	output reg out_always
);

	// Assign output using assign statement
	assign out_assign = (sel_b1 & sel_b2) ? b : a;

	// Assign output using always block
	always @(*) begin
		if (sel_b1 & sel_b2) 
			out_always = b;
		else 
			out_always = a;
	end

endmodule
