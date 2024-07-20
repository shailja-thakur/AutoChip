module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	reg [4:0] tap;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;
		else begin
			tap[4] <= tap[3] ^ tap[2] ^ tap[1] ^ q[31];
			tap[3:1] <= tap[2:0];
			tap[0] <= q[31];
			q <= {q[30:0], tap[4]};
		end
	end
endmodule
