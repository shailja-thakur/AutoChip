module top_module(
	input clk,
	input d,
	output reg q);

	reg d_pos;
	reg d_neg;

	// Positive edge triggered flip-flop
	always @(posedge clk) begin
		d_pos <= d;
	end

	// Negative edge triggered flip-flop
	always @(negedge clk) begin
		d_neg <= d;
	end

	// Output logic
	always @(posedge clk or negedge clk) begin
		if (clk)
			q <= d_pos;
		else
			q <= d_neg;
	end

endmodule
