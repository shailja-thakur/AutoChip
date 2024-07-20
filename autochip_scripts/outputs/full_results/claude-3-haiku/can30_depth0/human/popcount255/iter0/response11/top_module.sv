module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count in a tree-like structure
wire [31:0] count_32_1, count_32_2, count_32_3, count_32_4, count_32_5, count_32_6, count_32_7, count_32_8;
wire [15:0] count_16_1, count_16_2, count_16_3, count_16_4;
wire [7:0] count_8_1, count_8_2, count_8_3, count_8_4;

// 32-bit population count
assign count_32_1 = $countones(in[31:0]);
assign count_32_2 = $countones(in[63:32]);
assign count_32_3 = $countones(in[95:64]);
assign count_32_4 = $countones(in[127:96]);
assign count_32_5 = $countones(in[159:128]);
assign count_32_6 = $countones(in[191:160]);
assign count_32_7 = $countones(in[223:192]);
assign count_32_8 = $countones(in[254:224]);

// 16-bit population count
assign count_16_1 = count_32_1[15:0] + count_32_1[31:16];
assign count_16_2 = count_32_2[15:0] + count_32_2[31:16];
assign count_16_3 = count_32_3[15:0] + count_32_3[31:16];
assign count_16_4 = count_32_4[15:0] + count_32_4[31:16];

// 8-bit population count
assign count_8_1 = count_16_1[7:0] + count_16_1[15:8];
assign count_8_2 = count_16_2[7:0] + count_16_2[15:8];
assign count_8_3 = count_16_3[7:0] + count_16_3[15:8];
assign count_8_4 = count_16_4[7:0] + count_16_4[15:8];

// Final 8-bit output
always @(*) begin
    out = count_8_1 + count_8_2 + count_8_3 + count_8_4;
end

endmodule
