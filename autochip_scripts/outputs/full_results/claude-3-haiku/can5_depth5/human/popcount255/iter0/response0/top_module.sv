module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Population count using a binary tree approach
wire [31:0] level1, level2, level3, level4, level5, level6, level7, level8;

// Level 1
assign level1 = {in[254:248], in[247:241], in[240:234], in[233:227], in[226:220], in[219:213], in[212:206], in[205:199],
                in[198:192], in[191:185], in[184:178], in[177:171], in[170:164], in[163:157], in[156:150], in[149:143],
                in[142:136], in[135:129], in[128:122], in[121:115], in[114:108], in[107:101], in[100:94], in[93:87],
                in[86:80], in[79:73], in[72:66], in[65:59], in[58:52], in[51:45], in[44:38], in[37:31]};

// Level 2
assign level2 = {level1[31:30], level1[29:28], level1[27:26], level1[25:24], level1[23:22], level1[21:20], level1[19:18], level1[17:16],
                level1[15:14], level1[13:12], level1[11:10], level1[9:8], level1[7:6], level1[5:4], level1[3:2], level1[1:0]};

// Level 3
assign level3 = {level2[15:14], level2[13:12], level2[11:10], level2[9:8], level2[7:6], level2[5:4], level2[3:2], level2[1:0]};

// Level 4
assign level4 = {level3[7:6], level3[5:4], level3[3:2], level3[1:0]};

// Level 5
assign level5 = {level4[3:2], level4[1:0]};

// Level 6
assign level6 = {level5[1:0]};

// Level 7
assign level7 = {level6[0]};

// Level 8
assign level8 = {level7[0]};

// Output
always @* begin
    out = level8[7:0];
end

endmodule
