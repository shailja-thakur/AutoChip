module top_module (
	input a,
	input b,
	input sel_b1,
	input sel_b2,
	output out_assign,
	output reg out_always
);

	assign out_assign = (sel_b1 & sel_b2) ? b : a;   // assign statement for out_assign

	always @* begin   // always block for out_always
		if (sel_b1 & sel_b2) begin
			out_always = b;
		end else begin
			out_always = a;
		end
	end

endmodule
