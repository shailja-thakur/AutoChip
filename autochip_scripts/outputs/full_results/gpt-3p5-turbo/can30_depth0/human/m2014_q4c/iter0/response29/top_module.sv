module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	always_ff @(posedge clk)
	begin
		if (r==1'b1)
			q <= 1'b0;
		else
			q <= d;
	end

endmodule
