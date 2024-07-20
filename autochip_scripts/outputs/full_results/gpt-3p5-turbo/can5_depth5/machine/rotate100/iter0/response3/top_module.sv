module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] q_reg;

	always @(posedge clk) begin
		if (load)
			q_reg <= data;
		else begin
			if (ena == 2'b01)
				q_reg <= {q_reg[98:0], 1'b0};
			else if (ena == 2'b10)
				q_reg <= {1'b0, q_reg[99:1]};
		end
	end

	assign q = q_reg;

endmodule
