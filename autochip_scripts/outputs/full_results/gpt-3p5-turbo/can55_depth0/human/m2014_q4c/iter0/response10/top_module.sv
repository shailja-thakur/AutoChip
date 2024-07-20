module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	reg q_reg;

	always_ff @(posedge clk, posedge r) begin
		if (r)
			q_reg <= 0;
		else
			q_reg <= d;
	end

	assign q = q_reg;

endmodule
