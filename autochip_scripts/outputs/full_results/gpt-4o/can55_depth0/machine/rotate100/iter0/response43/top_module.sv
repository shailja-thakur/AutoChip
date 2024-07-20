module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	always @(posedge clk) begin
		if (load)
			q <= data;
		else if (ena == 2'h1)
			q <= q << 1;
		else if (ena == 2'h2)
			q <= q >> 1;
	end

endmodule
