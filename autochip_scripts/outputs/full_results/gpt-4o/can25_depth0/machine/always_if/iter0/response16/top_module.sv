module top_module (
	input a,
	input b,
	input sel_b1,
	input sel_b2,
	output out_assign,
	output reg out_always
);

	// Assign statement to output either a or b based on select signals
	assign out_assign = (sel_b1 && sel_b2) ? b : a;

	// Always block to output either a or b based on select signals
	always @ (a or b or sel_b1 or sel_b2) begin
		if (sel_b1 && sel_b2)
			out_always = b;
		else
			out_always = a;
	end

endmodule
