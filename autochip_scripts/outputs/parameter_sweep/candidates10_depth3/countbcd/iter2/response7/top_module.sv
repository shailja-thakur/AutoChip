module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] q_ones;
	reg [3:0] q_tens;
	reg [3:1] ena_temp;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_ones <= 4'b0;
			q_tens <= 4'b0;
		end else begin
			q_ones <= q_ones + (ena[1] ? 1 : 0);
			q_tens <= q_tens + (ena[2] ? 1 : 0);
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			ena_temp <= 3'b0;
		end else begin
			ena_temp <= ena;
		end
	end

	always @(posedge clk) begin
		q[3:0] <= q_ones;
		q[7:4] <= q_tens;
		q[11:8] <= (ena_temp[1] ? q[11:8] + 1 : q[11:8]);
		q[15:12] <= (ena_temp[2] ? q[15:12] + 1 : q[15:12]);
	end

	assign ena = ena_temp;

endmodule
