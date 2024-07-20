module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	reg [7:0] q_temp; // Temporary signal to hold the flip-flop outputs
	
	// Synchronous reset
	always @(posedge clk) begin
		if (reset == 1'b1)
			q_temp <= 8'b0;
		else
			q_temp <= d;
	end
	
	// Assign flip-flop outputs to q
	always @(posedge clk) begin
		q <= q_temp;
	end
	
endmodule
