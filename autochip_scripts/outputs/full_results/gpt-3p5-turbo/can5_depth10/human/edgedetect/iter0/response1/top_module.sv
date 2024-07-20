module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	always @(posedge clk) begin
		// Loop through each bit in the input vector
		for (integer i = 0; i < 8; i = i + 1) begin
			if (in[i] == 1 && in[i-1] == 0)
				pedge[i] <= 1;
			else
				pedge[i] <= 0;
		end
	end

endmodule
