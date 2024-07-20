module top_module(
	input clk,
	input d,
	output reg q);

	reg q_pos, q_neg;

	// Positive edge triggered D flip-flop
	always @(posedge clk) begin
		q_pos <= d;
	end

	// Negative edge triggered D flip-flop
	always @(negedge clk) begin
		q_neg <= d;
	end

	// Combine both to behave like a dual-edge triggered flip-flop
	always @(posedge clk or negedge clk) begin
		if (clk)
			q <= q_pos;
		else
			q <= q_neg;
	end

endmodule
