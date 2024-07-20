module top_module(
	input clk,
	input d,
	output reg q);
	
	reg q_pos; // Positive edge-triggered flip-flop output
	reg q_neg; // Negative edge-triggered flip-flop output

	// Positive edge-triggered flip-flop
	always @(posedge clk) begin
		q_pos <= d;
	end

	// Negative edge-triggered flip-flop
	always @(negedge clk) begin
		q_neg <= d;
	end
	
	// Combine results from both edge-triggered flip-flops
	always @(posedge clk or negedge clk) begin
		q <= clk ? q_pos : q_neg;
	end
endmodule
