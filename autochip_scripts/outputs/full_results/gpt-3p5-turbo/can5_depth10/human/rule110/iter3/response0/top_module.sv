module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] prev_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			prev_q = q;
			q[0] <= (prev_q[1] & prev_q[0]) | (~prev_q[1] & ~prev_q[0]);
			for (int i=1; i<511; i=i+1) begin
				q[i] <= (prev_q[i+1] & (prev_q[i] | ~prev_q[i-1])) | (~prev_q[i+1] & (~prev_q[i-1] | prev_q[i]));
			end
			q[511] <= (prev_q[511-1] & prev_q[511]) | (~prev_q[511-1] & ~prev_q[511]);
		end
	end

endmodule
