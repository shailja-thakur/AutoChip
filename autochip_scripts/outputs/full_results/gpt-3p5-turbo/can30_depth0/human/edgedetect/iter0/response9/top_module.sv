module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] next_state;

	always @(posedge clk) begin
		for (integer i = 0; i < 8; i = i + 1) begin
			if (in[i] == 1'b1 && next_state[i] == 1'b0)
				pedge[i] <= 1'b1;
			else
				pedge[i] <= 1'b0;
			next_state[i] <= in[i];
		end
	end

endmodule
