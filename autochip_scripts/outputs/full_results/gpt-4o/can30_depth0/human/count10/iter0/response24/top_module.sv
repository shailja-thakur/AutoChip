module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset) 
			q <= 4'd0;	// Reset counter to 0
		else if (q == 4'd9) 
			q <= 4'd0;	// Reset counter to 0 after counting to 9
		else 
			q <= q + 1'd1;	// Increment counter
	end

endmodule
