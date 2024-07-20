module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	always_ff @(posedge clk) begin
		if (r == 1)             // check r is high
			q <= 0;             // reset q to 0
		else 
			q <= d;             // update q with input d
	end

endmodule
