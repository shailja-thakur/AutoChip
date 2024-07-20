module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
    
	// Create 8 D flip-flops with active high synchronous reset
	always @(negedge clk) begin
		if (reset)
			q <= 8'b00110100;
		else
			q <= d;
	end

endmodule
