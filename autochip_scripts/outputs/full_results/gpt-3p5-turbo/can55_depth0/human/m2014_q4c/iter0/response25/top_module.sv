module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	reg q;

	always @(posedge clk or posedge r)
		if(r)
			q <= 0;
		else
			q <= d;

endmodule
