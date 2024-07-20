module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q[0] <= 0;
			for (int i=1; i<511; i=i+1) begin
				if (i == 1) begin
					q[i] <= ((q[i+1] & (q[i] | ~q[i-1])) | (~q[i+1] & (~q[i-1] | q[i]))) & ~load;
				end else if (i == 510) begin
					q[i] <= ((q[i+1] & (q[i] | ~q[i-1])) | (~q[i+1] & (~q[i-1] | q[i]))) & ~load;
				end else if (i == 511) begin
					q[i] <= ((q[510] & q[511]) | (~q[510] & ~q[511])) & ~load;
				end else begin
					q[i] <= ((q[i+1] & (q[i] | ~q[i-1])) | (~q[i+1] & (~q[i-1] | q[i])));
				end
			end
		end
	end

endmodule
