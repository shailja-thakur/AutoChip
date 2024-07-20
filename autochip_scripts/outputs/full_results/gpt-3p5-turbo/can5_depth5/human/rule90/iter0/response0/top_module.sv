module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load)
			q <= data;
		else begin
			// Shift data right by 1 bit
			q[511] <= q[510];
			for (int i = 510; i >= 1; i = i - 1)
				q[i] <= q[i-1] ^ q[i+1];
			q[0] <= q[1];
		end
	end
	
endmodule
