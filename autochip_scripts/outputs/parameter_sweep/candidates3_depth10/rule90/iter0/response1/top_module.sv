module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q[0] <= ((q[511] ^ q[0]) ^ q[1]);
			for (int i = 1; i < 512-1; i = i + 1) begin
				q[i] <= ((q[i-1] ^ q[i]) ^ q[i+1]);
			end
			q[512-1] <= ((q[512-2] ^ q[512-1]) ^ q[0]);
		end
	end
	
endmodule
