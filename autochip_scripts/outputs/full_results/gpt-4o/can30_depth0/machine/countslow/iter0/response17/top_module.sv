module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	// Synchronous counter logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 4'd0; // asynchronously reset q to 0
		end else if (slowena) begin
			if (q == 4'd9) begin
				q <= 4'd0; // reset q to 0 when it reaches 9
			end else begin
				q <= q + 4'd1; // increment q by 1
			end
		end
	end 

endmodule
