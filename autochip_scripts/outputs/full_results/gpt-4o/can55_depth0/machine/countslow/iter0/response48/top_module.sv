module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 4'b0000; // Asynchronous reset
		end 
		else if (slowena) begin
			if (q == 4'b1001) begin // Check if q equals 9
				q <= 4'b0000; // Reset to 0
			end else begin
				q <= q + 1; // Increment counter
			end
		end
	end

endmodule
