module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Define internal signals
	reg [15:0] next_q;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
		end else begin
			q <= next_q;
		end
	end

	always @(posedge clk) begin
		if (ena[1]) begin
			next_q[7:4] <= next_q[7:4] + 1;
		end
		if (ena[2]) begin
			next_q[11:8] <= next_q[11:8] + 1;
		end
		if (ena[3]) begin
			next_q[15:12] <= next_q[15:12] + 1;
		end
		next_q[3:0] <= next_q[3:0] + 1;
	end

endmodule
