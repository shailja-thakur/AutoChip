module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	reg [31:0] q_next;
	
	always @(posedge clk) begin
		if (reset)
			q <= 32'h1;
		else
			q <= q_next;
		
		q_next[0] = q[0] ^ q[1];
		q_next[1] = q[1] ^ q[0];
		for (i = 2; i <= 31; i = i+1)
			q_next[i] = q[i-1];
			
		if (q[0]) begin
			q_next[31] = q[21] ^ q[1];
		end else begin
			q_next[31] = q[21];
		end
	end
	
endmodule
