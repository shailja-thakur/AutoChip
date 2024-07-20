module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Pipelined population count circuit
wire [254:0] level1, level2, level3, level4, level5, level6, level7;

// Level 1: Count bits in groups of 4
assign level1 = {in[254:252] + in[251:249], in[248:246] + in[245:243], in[242:240] + in[237:235], in[234:232] + in[229:227],
                in[226:224] + in[221:219], in[218:216] + in[213:211], in[210:208] + in[205:203], in[202:200] + in[197:195],
                in[194:192] + in[189:187], in[186:184] + in[181:179], in[178:176] + in[173:171], in[170:168] + in[165:163],
                in[162:160] + in[157:155], in[154:152] + in[149:147], in[146:144] + in[141:139], in[138:136] + in[133:131],
                in[130:128] + in[125:123], in[122:120] + in[117:115], in[114:112] + in[109:107], in[106:104] + in[101:99],
                in[98:96] + in[93:91], in[90:88] + in[85:83], in[82:80] + in[77:75], in[74:72] + in[69:67],
                in[66:64] + in[61:59], in[58:56] + in[53:51], in[50:48] + in[45:43], in[42:40] + in[37:35],
                in[34:32] + in[29:27], in[26:24] + in[21:19], in[18:16] + in[13:11], in[10:8] + in[5:3]};

// Level 2: Add adjacent pairs
assign level2 = {level1[63:60] + level1[59:56], level1[55:52] + level1[51:48], level1[47:44] + level1[43:40], level1[39:36] + level1[35:32],
                level1[31:28] + level1[27:24], level1[23:20] + level1[19:16], level1[15:12] + level1[11:8], level1[7:4] + level1[3:0]};

// Level 3: Add adjacent pairs
assign level3 = {level2[31:28] + level2[27:24], level2[23:20] + level2[19:16], level2[15:12] + level2[11:8], level2[7:4] + level2[3:0]};

// Level 4: Add adjacent pairs
assign level4 = {level3[15:12] + level3[11:8], level3[7:4] + level3[3:0]};

// Level 5: Add adjacent pairs
assign level5 = {level4[7:4] + level4[3:0]};

// Level 6: Add adjacent pairs
assign level6 = {level5[3:0] + level5[3:0]};

// Level 7: Final output
always @(*) begin
    out = level6[3:0];
end

endmodule
