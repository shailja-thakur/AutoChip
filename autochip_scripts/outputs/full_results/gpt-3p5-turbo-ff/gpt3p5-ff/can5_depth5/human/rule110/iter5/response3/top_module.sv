module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] q_temp;

	always @(posedge clk or posedge load) begin
		if (load) begin
			q_temp <= data;
		end else begin
			q_temp[511] <= 0;
			for (int i = 0; i < 511; i = i + 1) begin
				q_temp[i] <= ((q_temp[i+1] & q_temp[i]) ^ (~q_temp[i+1] & ~q_temp[i]) ^ (q_temp[i+1] & ~q_temp[i]));
			end
		end
	end

	always @(posedge clk) begin
		q <= q_temp;
	end

endmodule
