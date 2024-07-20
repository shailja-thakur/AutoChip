module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 16'b0;
		end else begin
			// Ones digit increment
			if (q[3:0] == 4'b1001) begin
				q[3:0] <= 4'b0000;
				q[7:4] <= q[7:4] + 1;
			end else begin
				q[3:0] <= q[3:0] + 1;
			end

			// Tens digit increment
			if (q[7:4] == 4'b1001 && q[3:0] == 4'b1001) begin
				q[7:4] <= 4'b0000;
				q[11:8] <= q[11:8] + 1;
			end

			// Hundreds digit increment
			if (q[11:8] == 4'b1001 && q[7:4] == 4'b1001 && q[3:0] == 4'b1001) begin
				q[11:8] <= 4'b0000;
				q[15:12] <= q[15:12] + 1;
			end

			// Thousands digit increment
			if (q[15:12] == 4'b1001 && q[11:8] == 4'b1001 && q[7:4] == 4'b1001 && q[3:0] == 4'b1001) begin
				q[15:12] <= 4'b0000;
			end
		end
	end

	assign ena[1] = (q[3:0] == 4'b1001);
	assign ena[2] = (q[7:4] == 4'b1001 && q[3:0] == 4'b1001);
	assign ena[3] = (q[11:8] == 4'b1001 && q[7:4] == 4'b1001 && q[3:0] == 4'b1001);

endmodule
