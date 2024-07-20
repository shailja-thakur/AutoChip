module top_module(
	input clk,
	input d,
	output reg q);

	reg q_pos, q_neg;

	// Process triggered on positive edge
	always @(posedge clk) begin
		q_pos <= d;
	end

	// Process triggered on negative edge
	always @(negedge clk) begin
		q_neg <= d;
	end

	// Final output combining both edge-triggered updates
	always @(posedge clk or negedge clk) begin
		if (clk)
			q <= q_pos;
		else
			q <= q_neg;
	end

endmodule
