module top_module (
  input [254:0] in,
  output reg [7:0] out
);

  // Define a wire to hold the sum of the input bits
  wire [7:0] sum;

  // Population count
  assign sum = in[0] + in[1] + in[2] + in[3] + in[4] + in[5] + in[6] + in[7] + in[8] + in[9] +
               in[10] + in[11] + in[12] + in[13] + in[14] + in[15] + in[16] + in[17] + in[18] + in[19] +
               in[20] + in[21] + in[22] + in[23] + in[24] + in[25] + in[26] + in[27] + in[28] + in[29] +
               in[30] + in[31] + in[32] + in[33] + in[34] + in[35] + in[36] + in[37] + in[38] + in[39] +
               in[40] + in[41] + in[42] + in[43] + in[44] + in[45] + in[46] + in[47] + in[48] + in[49] +
               in[50] + in[51] + in[52] + in[53] + in[54] + in[55] + in[56] + in[57] + in[58] + in[59] +
               in[60] + in[61] + in[62] + in[63] + in[64] + in[65] + in[66] + in[67] + in[68] + in[69] +
               in[70] + in[71] + in[72] + in[73] + in[74] + in[75] + in[76] + in[77] + in[78] + in[79] +
               in[80] + in[81] + in[82] + in[83] + in[84] + in[85] + in[86] + in[87] + in[88] + in[89] +
               in[90] + in[91] + in[92] + in[93] + in[94] + in[95] + in[96] + in[97] + in[98] + in[99] +
               in[100] + in[101] + in[102] + in[103] + in[104] + in[105] + in[106] + in[107] + in[108] + in[109] +
               in[110] + in[111] + in[112] + in[113] + in[114] + in[115] + in[116] + in[117] + in[118] + in[119] +
               in[120] + in[121] + in[122] + in[123] + in[124] + in[125] + in[126] + in[127] + in[128] + in[129] +
               in[130] + in[131] + in[132] + in[133] + in[134] + in[135] + in[136] + in[137] + in[138] + in[139] +
               in[140] + in[141] + in[142] + in[143] + in[144] + in[145] + in[146] + in[147] + in[148] + in[149] +
               in[150] + in[151] + in[152] + in[153] + in[154] + in[155] + in[156] + in[157] + in[158] + in[159] +
               in[160] + in[161] + in[162] + in[163] + in[164] + in[165] + in[166] + in[167] + in[168] + in[169] +
               in[170] + in[171] + in[172] + in[173] + in[174] + in[175] + in[176] + in[177] + in[178] + in[179] +
               in[180] + in[181] + in[182] + in[183] + in[184] + in[185] + in[186] + in[187] + in[188] + in[189] +
               in[190] + in[191] + in[192] + in[193] + in[194] + in[195] + in[196] + in[197] + in[198] + in[199] +
               in[200] + in[201] + in[202] + in[203] + in[204] + in[205] + in[206] + in[207] + in[208] + in[209] +
               in[210] + in[211] + in[212] + in[213] + in[214] + in[215] + in[216] + in[217] + in[218] + in[219] +
               in[220] + in[221] + in[222] + in[223] + in[224] + in[225] + in[226] + in[227] + in[228] + in[229] +
               in[230] + in[231] + in[232] + in[233] + in[234] + in[235] + in[236] + in[237] + in[238] + in[239] +
               in[240] + in[241] + in[242] + in[243] + in[244] + in[245] + in[246] + in[247] + in[248] + in[249] +
               in[250] + in[251] + in[252] + in[253] + in[254];

  // Assign the sum to the output
  always @(sum)
    out = sum;

endmodule
