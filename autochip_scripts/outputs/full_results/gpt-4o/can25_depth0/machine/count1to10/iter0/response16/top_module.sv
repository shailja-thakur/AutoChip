module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Initial block to set the output register to 1 at the beginning
	initial begin
		q = 4'b0001;
	end

	// Always block triggered on the rising edge of the clock or when reset is active
	always @(posedge clk or posedge reset) begin
		// If reset is active, set q to 1
		if (reset) begin
			q <= 4'b0001;
		end
		else begin
			// If q has reached 10, reset to 1
			if (q == 4'b1010) begin
				q <= 4'b0001;
			end
			else begin
				// Increment q by 1
				q <= q + 1;
			end
		end
	end
endmodule
