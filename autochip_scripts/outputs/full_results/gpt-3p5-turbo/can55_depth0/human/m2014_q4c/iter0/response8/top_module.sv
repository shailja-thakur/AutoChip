module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	always_ff @(posedge clk) begin
		if (r)             // check if reset is high
			q <= 0;       // reset q to 0
		else
			q <= d;       // update q with d on positive edge of clock
	end

endmodule
