module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] q_next;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= q_next;
		end
	end

	// Generate the 16x16 grid toroid
	// Wraparound for x-axis
	assign q_next[0] = (q[15] + q[1] + q[240] + q[16] + q[31] + q[241] + q[256] + q[17] == 3) ? 1'b1 : 1'b0;
	assign q_next[15] = (q[14] + q[0] + q[239] + q[31] + q[30] + q[255] + q[15] + q[14] == 3) ? 1'b1 : 1'b0;
	assign q_next[240] = (q[255] + q[241] + q[224] + q[0] + q[15] + q[16] + q[31] + q[240] == 3) ? 1'b1 : 1'b0;
	assign q_next[255] = (q[254] + q[240] + q[239] + q[15] + q[14] + q[254] + q[16] + q[255] == 3) ? 1'b1 : 1'b0;

	// Wraparound for y-axis
	assign q_next[16] = (q[31] + q[17] + q[0] + q[1] + q[256] + q[240] + q[271] + q[257] == 3) ? 1'b1 : 1'b0;
	assign q_next[31] = (q[30] + q[16] + q[15] + q[0] + q[255] + q[239] + q[270] + q[256] == 3) ? 1'b1 : 1'b0;
	assign q_next[240] = (q[255] + q[241] + q[256] + q[257] + q[0] + q[224] + q[15] + q[16] == 3) ? 1'b1 : 1'b0;
	assign q_next[255] = (q[254] + q[240] + q[254] + q[255] + q[239] + q[224] + q[254] + q[0] == 3) ? 1'b1 : 1'b0;

	// Corners
	assign q_next[0] = (q[15] + q[1] + q[240] + q[16] == 3) ? 1'b1 : 1'b0;
	assign q_next[15] = (q[14] + q[0] + q[31] + q[240] == 3) ? 1'b1 : 1'b0;
	assign q_next[240] = (q[255] + q[241] + q[0] + q[256] == 3) ? 1'b1 : 1'b0;
	assign q_next[255] = (q[254] + q[240] + q[255] + q[224] == 3) ? 1'b1 : 1'b0;

	// Inner cells
	generate
		for (int i = 1; i < 15; i = i + 1) begin
			assign q_next[i] = (q[i-1] + q[i+1] + q[i+15] + q[i+16] + q[i+17] + q[i-16] + q[i-15] + q[i-17]) == 3) ? 1'b1 : 1'b0;
		end
	endgenerate

endmodule
