module top_module(
	input clk,
	input d,
	output reg q);

	reg q_pos;  // Flip-flop triggered on posedge clk
	reg q_neg;  // Flip-flop triggered on negedge clk

	always @(posedge clk) begin
		q_pos <= d;
	end

	always @(negedge clk) begin
		q_neg <= d;
	end

	always @(*) begin
		if (clk)
			q = q_pos;  // When clk is high, take value from posedge triggered flip-flop
		else
			q = q_neg;  // When clk is low, take value from negedge triggered flip-flop
	end

endmodule
