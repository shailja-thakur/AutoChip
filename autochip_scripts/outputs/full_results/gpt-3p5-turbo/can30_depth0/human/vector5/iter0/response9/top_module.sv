module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
	reg [24:0] temp;

	assign temp[24] = ~a ^ a;
	assign temp[23] = ~a ^ b;
	assign temp[22] = ~a ^ c;
	assign temp[21] = ~a ^ d;
	assign temp[20] = ~a ^ e;
	assign temp[19] = ~b ^ a;
	assign temp[18] = ~b ^ b;
	assign temp[17] = ~b ^ c;
	assign temp[16] = ~b ^ d;
	assign temp[15] = ~b ^ e;
	assign temp[14] = ~c ^ a;
	assign temp[13] = ~c ^ b;
	assign temp[12] = ~c ^ c;
	assign temp[11] = ~c ^ d;
	assign temp[10] = ~c ^ e;
	assign temp[9] = ~d ^ a;
	assign temp[8] = ~d ^ b;
	assign temp[7] = ~d ^ c;
	assign temp[6] = ~d ^ d;
	assign temp[5] = ~d ^ e;
	assign temp[4] = ~e ^ a;
	assign temp[3] = ~e ^ b;
	assign temp[2] = ~e ^ c;
	assign temp[1] = ~e ^ d;
	assign temp[0] = ~e ^ e;

	assign out = temp;
endmodule
