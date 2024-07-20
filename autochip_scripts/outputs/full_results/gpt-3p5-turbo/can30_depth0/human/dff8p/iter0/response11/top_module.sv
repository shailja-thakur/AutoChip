module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	reg [7:0] q_temp; // Temporary register for syncing with clk

	// D flip-flops with active high synchronous reset
	always @(negedge clk) begin
		if (reset)
			q_temp <= 8'h34;
		else
			q_temp <= d;
	end

	// Output register
	always @(posedge clk)
		q <= q_temp;

endmodule
