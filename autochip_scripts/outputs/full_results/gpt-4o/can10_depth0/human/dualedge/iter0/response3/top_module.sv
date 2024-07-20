module top_module(
	input clk,
	input d,
	output reg q);

	reg q_pos, q_neg;  // Internal flip-flops for positive and negative clock edges

	// Positive edge
	always @(posedge clk) begin
		q_pos <= d;
	end
	
	// Negative edge
	always @(negedge clk) begin
		q_neg <= d;
	end
	
	// Output logic
	always @(posedge clk or negedge clk) begin
		if (clk)
			q <= q_pos;
		else
			q <= q_neg;
	end

endmodule
