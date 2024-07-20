module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	reg [31:0] q_next;
	
	always @(posedge clk) begin
		if (reset)
			q <= 32'h1;
		else begin
			q <= q_next;
			q_next[0] = q[1] ^ q[0];
			q_next[1:31] = q[2:31];
			q_next[31] = q[0];
		end
	end
	
endmodule
