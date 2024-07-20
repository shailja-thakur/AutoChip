module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Declare internal signal
	reg [3:0] temp_q;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
			temp_q <= 0;
		end else begin
			temp_q <= temp_q + 1;
			q[3:0] <= temp_q[3:0];
			q[7:4] <= temp_q[7:4];
			q[11:8] <= temp_q[11:8];
			q[15:12] <= temp_q[15:12];
		end
	end

	// Set enable signals
	assign ena[1] = (temp_q[3:0] == 9);
	assign ena[2] = (temp_q[7:4] == 9);
	assign ena[3] = (temp_q[11:8] == 9);

endmodule
