module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] q_temp;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_temp <= 4'b0000;
			q <= 16'b0000;
		end else if (ena[1]) begin
			q_temp <= q_temp + 4'b0001;
		end else if (ena[2]) begin
			q_temp <= q_temp + 4'b0010;
		end else if (ena[3]) begin
			q_temp <= q_temp + 4'b0100;
		end
	end
	
	always @(posedge clk) begin
		q[3:0] <= q_temp;
		q[7:4] <= q_temp;
		q[11:8] <= q_temp;
		q[15:12] <= q_temp;
	end
endmodule
