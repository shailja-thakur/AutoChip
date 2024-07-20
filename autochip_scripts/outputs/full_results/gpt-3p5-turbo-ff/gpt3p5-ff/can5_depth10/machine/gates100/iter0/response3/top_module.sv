module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Declaration of intermediate signal
	wire [99:0] and_wire;
	wire [99:0] or_wire;

	// AND logic
	and_gate and_inst (
		.in1(in),
		.in2(and_wire)
	);

	// OR logic
	or_gate or_inst (
		.in1(in),
		.in2(or_wire)
	);

	// XOR logic
	xor_gate xor_inst (
		.in1(in),
		.in2(out_xor)
	);

	assign out_and = and_wire[99] & and_wire[98] & and_wire[97] & and_wire[96] & and_wire[95] & and_wire[94] & and_wire[93] & and_wire[92] & and_wire[91] & and_wire[90] & and_wire[89] & and_wire[88] & and_wire[87] & and_wire[86] & and_wire[85] & and_wire[84] & and_wire[83] & and_wire[82] & and_wire[81] & and_wire[80] & and_wire[79] & and_wire[78] & and_wire[77] & and_wire[76] & and_wire[75] & and_wire[74] & and_wire[73] & and_wire[72] & and_wire[71] & and_wire[70] & and_wire[69] & and_wire[68] & and_wire[67] & and_wire[66] & and_wire[65] & and_wire[64] & and_wire[63] & and_wire[62] & and_wire[61] & and_wire[60] & and_wire[59] & and_wire[58] & and_wire[57] & and_wire[56] & and_wire[55] & and_wire[54] & and_wire[53] & and_wire[52] & and_wire[51] & and_wire[50] & and_wire[49] & and_wire[48] & and_wire[47] & and_wire[46] & and_wire[45] & and_wire[44] & and_wire[43] & and_wire[42] & and_wire[41] & and_wire[40] & and_wire[39] & and_wire[38] & and_wire[37] & and_wire[36] & and_wire[35] & and_wire[34] & and_wire[33] & and_wire[32] & and_wire[31] & and_wire[30] & and_wire[29] & and_wire[28] & and_wire[27] & and_wire[26] & and_wire[25] & and_wire[24] & and_wire[23] & and_wire[22] & and_wire[21] & and_wire[20] & and_wire[19] & and_wire[18] & and_wire[17] & and_wire[16] & and_wire[15] & and_wire[14] & and_wire[13] & and_wire[12] & and_wire[11] & and_wire[10] & and_wire[9] & and_wire[8] & and_wire[7] & and_wire[6] & and_wire[5] & and_wire[4] & and_wire[3] & and_wire[2] & and_wire[1] & and_wire[0];

	assign out_or = or_wire[99] | or_wire[98] | or_wire[97] | or_wire[96] | or_wire[95] | or_wire[94] | or_wire[93] | or_wire[92] | or_wire[91] | or_wire[90] | or_wire[89] | or_wire[88] | or_wire[87] | or_wire[86] | or_wire[85] | or_wire[84] | or_wire[83] | or_wire[82] | or_wire[81] | or_wire[80] | or_wire[79] | or_wire[78] | or_wire[77] | or_wire[76] | or_wire[75] | or_wire[74] | or_wire[73] | or_wire[72] | or_wire[71] | or_wire[70] | or_wire[69] | or_wire[68] | or_wire[67] | or_wire[66] | or_wire[65] | or_wire[64] | or_wire[63] | or_wire[62] | or_wire[61] | or_wire[60] | or_wire[59] | or_wire[58] | or_wire[57] | or_wire[56] | or_wire[55] | or_wire[54] | or_wire[53] | or_wire[52] | or_wire[51] | or_wire[50] | or_wire[49] | or_wire[48] | or_wire[47] | or_wire[46] | or_wire[45] | or_wire[44] | or_wire[43] | or_wire[42] | or_wire[41] | or_wire[40] | or_wire[39] | or_wire[38] | or_wire[37] | or_wire[36] | or_wire[35] | or_wire[34] | or_wire[33] | or_wire[32] | or_wire[31] | or_wire[30] | or_wire[29] | or_wire[28] | or_wire[27] | or_wire[26] | or_wire[25] | or_wire[24] | or_wire[23] | or_wire[22] | or_wire[21] | or_wire[20] | or_wire[19] | or_wire[18] | or_wire[17] | or_wire[16] | or_wire[15] | or_wire[14] | or_wire[13] | or_wire[12] | or_wire[11] | or_wire[10] | or_wire[9] | or_wire[8] | or_wire[7] | or_wire[6] | or_wire[5] | or_wire[4] | or_wire[3] | or_wire[2] | or_wire[1] | or_wire[0];

endmodule
module and_gate (
	input [99:0] in1,
	output [99:0] in2
);
	assign in2 = in1;
endmodule
module or_gate (
	input [99:0] in1,
	output [99:0] in2
);
	assign in2 = in1;
endmodule
module xor_gate (
	input [99:0] in1,
	output in2
);
	assign in2 = in1[99] ^ in1[98] ^ in1[97] ^ in1[96] ^ in1[95] ^ in1[94] ^ in1[93] ^ in1[92] ^ in1[91] ^ in1[90] ^ in1[89] ^ in1[88] ^ in1[87] ^ in1[86] ^ in1[85] ^ in1[84] ^ in1[83] ^ in1[82] ^ in1[81] ^ in1[80] ^ in1[79] ^ in1[78] ^ in1[77] ^ in1[76] ^ in1[75] ^ in1[74] ^ in1[73] ^ in1[72] ^ in1[71] ^ in1[70] ^ in1[69] ^ in1[68] ^ in1[67] ^ in1[66] ^ in1[65] ^ in1[64] ^ in1[63] ^ in1[62] ^ in1[61] ^ in1[60] ^ in1[59] ^ in1[58] ^ in1[57] ^ in1[56] ^ in1[55] ^ in1[54] ^ in1[53] ^ in1[52] ^ in1[51] ^ in1[50] ^ in1[49] ^ in1[48] ^ in1[47] ^ in1

[46] ^ in1[45] ^ in1[44] ^ in1[43] ^ in1[42] ^ in1[41] ^ in1[40] ^ in1[39] ^ in1[38] ^ in1[37] ^ in1[36] ^ in1[35] ^ in1[34] ^ in1[33] ^ in1[32] ^ in1[31] ^ in1[30] ^ in1[29] ^ in1[28] ^ in1[27] ^ in1[26] ^ in1[25] ^ in1[24] ^ in1[23] ^ in1[22] ^ in1[21] ^ in1[20] ^ in1[19] ^ in1[18] ^ in1[17] ^ in1[16] ^ in1[15] ^ in1[14] ^ in1[13] ^ in1[12] ^ in1[11] ^ in1[10] ^ in1[9] ^ in1[8] ^ in1[7] ^ in1[6] ^ in1[5] ^ in1[4] ^ in1[3] ^ in1[2] ^ in1[1] ^ in1[0];
endmodule
