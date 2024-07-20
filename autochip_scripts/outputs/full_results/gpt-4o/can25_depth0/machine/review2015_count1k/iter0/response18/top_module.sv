module top_module(
	input clk,
	input reset,
	output reg [9:0] q);
	
	// Always block triggered on the positive edge of the clock or when reset is active
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 10'b0; // Reset output register to 0 when reset is active
		end
		else if (q == 10'd999) begin
			q <= 10'b0; // Reset to 0 when count reaches 999
		end
		else begin
			q <= q + 1; // Increment output register by 1
		end
	end
	
endmodule
