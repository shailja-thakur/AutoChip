module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk or posedge load) begin
		if(load)
			q <= data;
		else begin
			q[0] = data[511] ^ data[0] ^ data[1];
			for(int i = 1; i < 511; i=i+1)
				q[i] = data[i-1] ^ data[i] ^ data[i+1];
			q[511] = data[510] ^ data[511] ^ data[0];
		end
	end

endmodule
