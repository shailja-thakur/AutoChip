module top_module (
    input [254:0] in,
    output reg [7:0] out
);

wire [31:0] count_0, count_1, count_2, count_3, count_4, count_5, count_6, count_7;

// Stage 1: Count 1's in each 32-bit chunk
assign count_0 = $countones(in[31:0]);
assign count_1 = $countones(in[63:32]);
assign count_2 = $countones(in[95:64]);
assign count_3 = $countones(in[127:96]);
assign count_4 = $countones(in[159:128]);
assign count_5 = $countones(in[191:160]);
assign count_6 = $countones(in[223:192]);
assign count_7 = $countones(in[254:224]);

// Stage 2: Combine the counts
always @* begin
    out = count_0[7:0] + count_1[7:0] + count_2[7:0] + count_3[7:0] +
          count_4[7:0] + count_5[7:0] + count_6[7:0] + count_7[7:0];
end

endmodule
