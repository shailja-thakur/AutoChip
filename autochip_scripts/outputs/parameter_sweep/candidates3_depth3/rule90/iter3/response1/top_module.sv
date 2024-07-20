module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] next_q;
	
	always @(posedge clk) begin
		if (load)
			next_q <= data;
		else begin
			next_q[0] = (q[1] & q[0]) ^ (~q[1] & ~q[0]);
			for (int i=1; i<511; i=i+1)
				next_q[i] = (q[i+1] & q[i] & ~q[i-1]) ^ (q[i+1] & ~q[i] & q[i-1]) ^ (q[i+1] & ~q[i] & ~q[i-1]) ^ (~q[i+1] & q[i] & q[i-1]);
			next_q[511] = (~q[511] & q[510]) ^ (q[511] & ~q[510]);
		end
	end
	
	always @(posedge clk) begin
		q <= next_q;
	end
	
	initial begin
		// Initialize the output to all 0s
		q = 512'b0;
	end
	
endmodule
