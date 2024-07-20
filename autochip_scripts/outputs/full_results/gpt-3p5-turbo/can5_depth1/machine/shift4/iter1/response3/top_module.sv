module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	reg [3:0] q_reg;

	always @(posedge clk) begin
		if (areset)
			q_reg <= 4'b0;
		else if (load)
			q_reg <= data;
		else if (ena)
			q_reg <= {q_reg[2:0], 1'b0};
	end

	always @(posedge clk) begin
		q <= q_reg;
	end

endmodule
