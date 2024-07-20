module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] feedback;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
			feedback <= 32'b0;
		end else begin
			feedback[0] <= q[31] ^ q[21] ^ q[1] ^ q[0];
			feedback[31:1] <= q[30:0];
			q <= feedback;
		end
	end

endmodule
