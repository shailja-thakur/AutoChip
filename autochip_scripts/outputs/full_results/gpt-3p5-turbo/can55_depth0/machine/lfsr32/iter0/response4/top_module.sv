module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	reg [31:0] q_next;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			q <= 32'h1;
		else
			q <= q_next;
	end
	
	always @(posedge clk)
	begin
		q_next[0] = q[0] ^ q[21] ^ q[1];
		
		for (i=1; i<=31; i=i+1)
			q_next[i] = q[i-1];
		
		q = q_next;
	end

endmodule
