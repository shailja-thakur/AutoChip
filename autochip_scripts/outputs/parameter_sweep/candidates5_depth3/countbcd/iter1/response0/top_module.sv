module top_module(
	input clk,
	input reset,
	output reg [2:0] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
			ena <= 0;
		end else begin
			q <= q + 1;
			if (q[3:0] == 10) begin
				q[3:0] <= 0;
				ena[2] <= 1;
			end else begin
				ena[2] <= 0;
			end
			
			if (q[7:4] == 10) begin
				q[7:4] <= 0;
				ena[1] <= 1;
			end else begin
				ena[1] <= 0;
			end
			
			if (q[11:8] == 10) begin
				q[11:8] <= 0;
				ena[0] <= 1;
			end else begin
				ena[0] <= 0;
			end
		end
	end
endmodule
