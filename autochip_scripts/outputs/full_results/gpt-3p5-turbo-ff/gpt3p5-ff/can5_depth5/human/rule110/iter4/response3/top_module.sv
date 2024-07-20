module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk or posedge load) begin
		if (load) begin
			q <= data;
		end else begin
			q[511] <= 0;
			for (int i = 0; i < 511; i = i + 1) begin
				q[i] <= ((q[i+1] & q[i]) ^ (~q[i+1] & ~q[i]) ^ (q[i+1] & ~q[i]));
			end
		end
	end

endmodule
