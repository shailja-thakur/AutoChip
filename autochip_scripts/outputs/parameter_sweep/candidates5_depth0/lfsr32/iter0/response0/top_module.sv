module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;
		else begin
			q <= {q[30:0], q[30] ^ q[20] ^ q[0] ^ q[31]};
		end
	end
endmodule
