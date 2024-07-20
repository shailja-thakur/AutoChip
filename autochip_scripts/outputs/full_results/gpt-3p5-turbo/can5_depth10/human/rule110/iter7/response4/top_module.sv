module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q[511] <= ((q[510] & q[511] & ~q[0]) | (~q[510] & ~q[511] & q[0]));
			for (int i = 510; i > 0; i=i-1) begin
				q[i] <= ((q[i-1] & (q[i] | ~q[i+1])) | (~q[i-1] & (~q[i+1] | q[i])));
			end
			q[0] <= 0;
		end
	end

endmodule
