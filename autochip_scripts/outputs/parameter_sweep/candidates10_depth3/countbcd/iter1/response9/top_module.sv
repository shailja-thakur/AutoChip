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
		end else begin
			if (ena[1])
				ena_reg[1] <= 1'b1;
			else if (ena[2])
				ena_reg[1:2] <= 2'b11;
			else if (ena[3])
				ena_reg <= 3'b111;

			if (ena_reg[1])
				q <= q + 16'b0001;
			else if (ena_reg[2])
				q <= q + 16'b0010;
			else if (ena_reg[3])
				q <= q + 16'b0100;
		end
	end
endmodule
