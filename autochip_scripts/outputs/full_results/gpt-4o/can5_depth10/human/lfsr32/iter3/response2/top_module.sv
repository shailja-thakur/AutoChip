module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk) begin
		if (reset)
			q <= 32'h1;
		else begin
			// Feedback is a bitwise XOR between specific tapped bits and the last bit
			q <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
		end
	end
endmodule
