module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	reg [31:0] q_next;
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			q <= 32'h1;
		end else begin
			q <= q_next;
		end
	end
	
	always @* begin
		q_next[0] = q[31] ^ q[21] ^ q[1];
		q_next[1] = q[0];
		for (int i=2; i<32; i=i+1)
			q_next[i] = q[i-1];
	end
endmodule
