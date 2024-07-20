module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
			ena <= 3'b111;
		end else begin
			q <= q + 1;
			if (q[3:0] == 4'b1010) begin
				q[3:0] <= 4'b0000;
				ena[1] <= 1;
			end
			if (q[7:4] == 4'b1010) begin
				q[7:4] <= 4'b0000;
				ena[2] <= 1;
			end
			if (q[11:8] == 4'b1010) begin
				q[11:8] <= 4'b0000;
				ena[3] <= 1;
			end
		end
	end

endmodule
