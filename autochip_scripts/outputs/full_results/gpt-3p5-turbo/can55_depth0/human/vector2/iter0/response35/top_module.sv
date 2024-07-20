module top_module (
	input [31:0] in,
	output [31:0] out
);
	reg [31:0] temp;
	
	always @ (in) begin
		temp[0] = in[31];
		temp[1] = in[30];
		temp[2] = in[29];
		temp[3] = in[28];
		temp[4] = in[27];
		temp[5] = in[26];
		temp[6] = in[25];
		temp[7] = in[24];
		temp[8] = in[23];
		temp[9] = in[22];
		temp[10] = in[21];
		temp[11] = in[20];
		temp[12] = in[19];
		temp[13] = in[18];
		temp[14] = in[17];
		temp[15] = in[16];
		temp[16] = in[15];
		temp[17] = in[14];
		temp[18] = in[13];
		temp[19] = in[12];
		temp[20] = in[11];
		temp[21] = in[10];
		temp[22] = in[9];
		temp[23] = in[8];
		temp[24] = in[7];
		temp[25] = in[6];
		temp[26] = in[5];
		temp[27] = in[4];
		temp[28] = in[3];
		temp[29] = in[2];
		temp[30] = in[1];
		temp[31] = in[0];
	end
	
	assign out = temp;
endmodule
