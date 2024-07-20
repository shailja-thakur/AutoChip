module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk) begin
		if (reset)
			q <= 32'h1;
		else
			q <= {q[30:0], q[0] ^ q[21] ^ q[1]};
	end
	
endmodule
