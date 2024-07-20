module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:1] ena_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
			ena_reg <= 3'b000;
		end
		else begin
			ena_reg <= ena;
			if (ena_reg[1])
				q[7:4] <= q[7:4] + 1;
			if (ena_reg[2])
				q[11:8] <= q[11:8] + 1;
			if (ena_reg[3])
				q[15:12] <= q[15:12] + 1;
			q[3:0] <= q[3:0] + 1;
		end
	end

endmodule
