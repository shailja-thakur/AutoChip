module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Initialize the output register
	initial q = 4'b0001;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 4'b0001;
		end else begin
			if (q == 4'b1010) begin // Check if q is 10
				q <= 4'b0001;
			end else begin
				q <= q + 1;
			end
		end
	end
endmodule
