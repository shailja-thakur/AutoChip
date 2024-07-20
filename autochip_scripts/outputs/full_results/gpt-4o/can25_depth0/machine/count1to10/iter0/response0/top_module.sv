module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 4'b0001; // Set output register to 1 when reset is active
		else begin
			if (q == 4'b1010) // When q reaches 10
				q <= 4'b0001; // Reset output register to 1
			else
				q <= q + 4'b0001; // Increment output register by 1
		end
	end

endmodule
