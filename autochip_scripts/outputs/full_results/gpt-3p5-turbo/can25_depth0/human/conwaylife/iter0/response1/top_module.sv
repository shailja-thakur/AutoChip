module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] next_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			next_q[255] <= (q[238] + q[255] + q[16] + q[0] + q[23] + q[15] + q[30] + q[31]) == 3;
			for (i = 1; i < 16; i = i + 1) begin
				next_q[(i + 1)*16 - 1] <= (q[i*16 - 1] + q[i*16] + q[i*16 + 1] + q[(i - 1)*16 - 1] + q[(i - 1)*16] + q[(i - 1)*16 + 1] + q[(i + 1)*16 - 1] + q[(i + 1)*16]) == 3;
				for (j = 1; j < 15; j = j + 1) begin
					next_q[i*16 + j] <= (q[i*16 + j - 1] + q[i*16 + j] + q[i*16 + j + 1] + q[(i - 1)*16 + j - 1] + q[(i - 1)*16 + j] + q[(i - 1)*16 + j + 1] + q[(i + 1)*16 + j - 1] + q[(i + 1)*16 + j]) == 3;
				end
				next_q[i*16] <= (q[i*16 - 1] + q[i*16] + q[i*16 + 1] + q[(i - 1)*16 - 1] + q[(i - 1)*16] + q[(i - 1)*16 + 1] + q[(i + 1)*16 - 1] + q[(i + 1)*16]) == 3;
				next_q[(i + 1)*16 - 1] <= (q[i*16 - 1] + q[i*16] + q[i*16 + 1] + q[(i - 1)*16 - 1] + q[(i - 1)*16] + q[(i - 1)*16 + 1] + q[(i + 1)*16 - 1] + (q + 1)*16) == 3;
			end
			next_q[240] <= (q[255] + q[240] + q[241] + q[15] + q[31] + q[16] + q[30] + q[14]) == 3;
			for (j = 1; j < 15; j = j + 1) begin
				next_q[240 + j] <= (q[240 + j - 1] + q[240 + j] + q[240 + j + 1] + q[240 - 1] + q[240] + q[240 + 1] + q[256 + j - 1] + q[256 + j]) == 3;
			end
			next_q[255] <= (q[254] + q[255] + q[240] + q[238] + q[240 - 1] + q[255 - 1] + q[240 + 1] + q[255 + 1]) == 3;
			q <= next_q;
		end
	end
endmodule
