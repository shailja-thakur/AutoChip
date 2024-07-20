module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	reg [255:0] in_reg [15:0];	// create an array of 16 256-bit registers
	genvar i;
	// divide the 1024-bit input vector into 256-bit chunks and store them into the array of registers
	generate
		for (i = 0; i < 16; i = i + 1) begin
			always @* begin
				in_reg[i] = in[((i+1)*256)-1 : i*256];
			end
		end
	endgenerate
	
	always @* begin
		case(sel)
			4'd0: out = in_reg[0][3:0];
			4'd1: out = in_reg[1][3:0];
			4'd2: out = in_reg[2][3:0];
			4'd3: out = in_reg[3][3:0];
			4'd4: out = in_reg[4][3:0];
			4'd5: out = in_reg[5][3:0];
			4'd6: out = in_reg[6][3:0];
			4'd7: out = in_reg[7][3:0];
			4'd8: out = in_reg[8][3:0];
			4'd9: out = in_reg[9][3:0];
			4'd10: out = in_reg[10][3:0];
			4'd11: out = in_reg[11][3:0];
			4'd12: out = in_reg[12][3:0];
			4'd13: out = in_reg[13][3:0];
			4'd14: out = in_reg[14][3:0];
			4'd15: out = in_reg[15][3:0];
			default: out = 4'b0;
		endcase
	end
endmodule
