module top_module (
	input x3,
	input x2,
	input x1,
	output reg f
);
	always @(*) begin
		// Determine the output signal f based on the given combinations
		if ((!x3 && x2 && !x1) || (!x3 && x2 && x1) || (x3 && !x2 && x1) || (x3 && x2 && x1)) begin
			f = 1'b1;
		end else begin
			f = 1'b0;
		end
	end
endmodule
