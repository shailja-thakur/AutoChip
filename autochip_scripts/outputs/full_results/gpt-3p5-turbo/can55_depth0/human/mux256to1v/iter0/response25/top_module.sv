module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	reg [3:0] temp [255:0]; // create an array of 256 4-bit registers

	// assign each group of 4 bits from the input to each register
	genvar i;
	generate
		for (i = 0; i < 256; i = i + 1) begin : assign_regs
			assign temp[i] = in[i*4 +: 4];
		end
	endgenerate

	// select the appropriate register based on the value of sel
	always @* begin
		case(sel)
			8'b00000000: out = temp[0];
			8'b00000001: out = temp[1];
			8'b00000010: out = temp[2];
			8'b00000011: out = temp[3];
			8'b00000100: out = temp[4];
			8'b00000101: out = temp[5];
			8'b00000110: out = temp[6];
			8'b00000111: out = temp[7];
			// add remaining cases for the other 248 selections
			default: out = 4'b0000;
		endcase
	end
endmodule
