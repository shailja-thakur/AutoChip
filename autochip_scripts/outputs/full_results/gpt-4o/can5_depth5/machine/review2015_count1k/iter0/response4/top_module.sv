module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	// Always block triggered on positive edge of clock or when reset is active
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// When reset is active, set q to 0
			q <= 10'b0;
		end else begin
			// When q reaches 999, reset q to 0, else increment q by 1
			if (q == 10'd999) begin
				q <= 10'b0;
			end else begin
				q <= q + 1;
			end
		end
	end
endmodule
