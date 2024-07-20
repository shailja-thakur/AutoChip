module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] q_temp;
	
	always@(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q_temp[0] <= data[1] ^ 0;
			q_temp[511] <= 0 ^ data[510];
			for (int i = 1; i < 511; i=i+1) begin
				q_temp[i] <= q[i-1] ^ q[i+1];
			end
			q <= q_temp;
		end
	end
endmodule
