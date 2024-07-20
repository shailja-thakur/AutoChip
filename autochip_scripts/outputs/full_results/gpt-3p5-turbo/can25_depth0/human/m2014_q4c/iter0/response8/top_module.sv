module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	always_ff @(posedge clk or posedge r)
		if (r)
			q <= 1'b0;
		else
			q <= d;

endmodule
