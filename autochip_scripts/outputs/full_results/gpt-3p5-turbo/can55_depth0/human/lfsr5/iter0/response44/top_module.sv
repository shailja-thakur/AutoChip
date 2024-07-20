module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] feedback;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 1;
		else begin
			feedback[4] <= q[3] ^ q[0];
			feedback[3] <= q[2] ^ q[0];
			feedback[2] <= q[1];
			feedback[1] <= q[0];
			feedback[0] <= 0;

			q <= feedback;
		end
	end

endmodule
