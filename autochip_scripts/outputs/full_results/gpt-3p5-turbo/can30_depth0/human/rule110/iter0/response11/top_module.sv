module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load)
			q <= data;
		else begin
			for (integer i = 0; i < 512; i = i + 1) begin
				// Handle boundary conditions
				if (i == 0)
					q[i] <= (q[1] & q[i] & ~q[2]) | (q[1] & ~q[i] & q[2]) | (q[1] & ~q[i] & ~q[2]) | (~q[1] & q[i] & q[2]);
				else if (i == 511)
					q[i] <= (q[510] & q[i] & ~q[511]) | (q[510] & ~q[i] & q[511]) | (q[510] & ~q[i] & ~q[511]) | (~q[510] & q[i] & q[511]);
				else
					q[i] <= (q[i-1] & q[i] & ~q[i+1]) | (q[i-1] & ~q[i] & q[i+1]) | (q[i-1] & ~q[i] & ~q[i+1]) | (~q[i-1] & q[i] & q[i+1]);
			end
		end
	end
endmodule
