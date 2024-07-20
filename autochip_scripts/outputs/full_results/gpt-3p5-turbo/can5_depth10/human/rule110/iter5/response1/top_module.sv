module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] temp;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			temp[0] <= (~q[1] & ~q[0]);
			for (int i=1; i<511; i=i+1) begin
				temp[i] <= (q[i+1] & (q[i] | ~q[i-1])) | (~q[i+1] & (~q[i-1] | q[i]));
			end
			temp[511] <= (q[511-1] & q[511]) | (~q[511-1] & ~q[511]);
		end
	end
	
	always @(posedge clk) begin
		q <= temp;
	end

endmodule
