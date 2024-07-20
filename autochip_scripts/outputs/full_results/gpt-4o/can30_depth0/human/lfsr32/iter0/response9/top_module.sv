module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end
		else begin
			q[0] <= q[31]; // Tapped bit
			q[1] <= q[0];  // Shift
			q[2] <= q[1] ^ q[31]; // Tapped bit
			q[3] <= q[2];  // Shift
			q[4] <= q[3];  // Shift
			q[5] <= q[4];  // Shift
			q[6] <= q[5];  // Shift
			q[7] <= q[6];  // Shift
			q[8] <= q[7];  // Shift
			q[9] <= q[8];  // Shift
			q[10] <= q[9];  // Shift
			q[11] <= q[10];  // Shift
			q[12] <= q[11];  // Shift
			q[13] <= q[12];  // Shift
			q[14] <= q[13];  // Shift
			q[15] <= q[14];  // Shift
			q[16] <= q[15];  // Shift
			q[17] <= q[16];  // Shift
			q[18] <= q[17];  // Shift
			q[19] <= q[18];  // Shift
			q[20] <= q[19];  // Shift
			q[21] <= q[20];  // Shift
			q[22] <= q[21] ^ q[31]; // Tapped bit
			q[23] <= q[22];  // Shift
			q[24] <= q[23];  // Shift
			q[25] <= q[24];  // Shift
			q[26] <= q[25];  // Shift
			q[27] <= q[26];  // Shift
			q[28] <= q[27];  // Shift
			q[29] <= q[28];  // Shift
			q[30] <= q[29];  // Shift
			q[31] <= q[30];  // Shift
		end
	end
endmodule
