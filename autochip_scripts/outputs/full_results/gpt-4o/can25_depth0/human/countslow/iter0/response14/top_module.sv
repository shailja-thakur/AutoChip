module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

    // Initialize the counter to 0
	initial 
		q = 4'd0;

	always @(posedge clk) begin
		if (reset) begin
			// Reset the counter to 0
			q <= 4'd0;
		end
		else if (slowena) begin
			// When slowena is high, increment the counter
			if (q == 4'd9) begin
				q <= 4'd0; // Wrap around to 0 at 9
			end
			else begin
				q <= q + 1;
			end
		end
        // If slowena is low, the counter maintains its value
	end

endmodule
