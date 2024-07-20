module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [512:0] q);

	reg [512:0] temp_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			temp_q[0] <= ((q[1] & q[0]) | ~q[1] & ~q[0]);
			for (int i = 1; i < 512; i = i + 1) begin
				temp_q[i] <= ((q[i + 1] & q[i]) | ~q[i + 1] & ~q[i] | q[i + 1] & ~q[i]);
			end
			temp_q[512] <= 0;
			q <= temp_q;
		end
	end

endmodule
