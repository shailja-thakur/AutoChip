module top_module (
	input a,
	input b,
	input sel_b1,
	input sel_b2,
	output out_assign,
	output reg out_always
);

	// assign statement to drive out_assign
	assign out_assign = (sel_b1 & sel_b2) ? b : a;

	// always block to drive out_always
	always @(*) begin
		if (sel_b1 & sel_b2) begin
			out_always = b;
		} else begin
			out_always = a;
		end
	end

endmodule
