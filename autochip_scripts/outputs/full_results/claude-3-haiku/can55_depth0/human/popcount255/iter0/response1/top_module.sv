module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count in a tree-like fashion
wire [31:0] count_32bit[7:0];
wire [15:0] count_16bit[15:0];
wire [7:0] count_8bit[31:0];

genvar i;

// Count 8-bit segments
generate
    for (i = 0; i < 32; i = i + 1) begin
        popcount_8bit pc8 (
            .in(in[i*8+7:i*8]),
            .out(count_8bit[i])
        );
    end
endgenerate

// Combine 8-bit counts to 16-bit counts
generate
    for (i = 0; i < 16; i = i + 1) begin
        popcount_16bit pc16 (
            .in({count_8bit[i*2+1], count_8bit[i*2]}),
            .out(count_16bit[i])
        );
    end
endgenerate

// Combine 16-bit counts to 32-bit counts
generate
    for (i = 0; i < 8; i = i + 1) begin
        popcount_32bit pc32 (
            .in({count_16bit[i*2+1], count_16bit[i*2]}),
            .out(count_32bit[i])
        );
    end
endgenerate

// Combine 32-bit counts to the final 8-bit output
always @(*) begin
    out = count_32bit[0][7:0] +
          count_32bit[1][7:0] +
          count_32bit[2][7:0] +
          count_32bit[3][7:0] +
          count_32bit[4][7:0] +
          count_32bit[5][7:0] +
          count_32bit[6][7:0] +
          count_32bit[7][7:0];
end

// Sub-modules
module popcount_8bit (
    input [7:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = in[0] + in[1] + in[2] + in[3] + in[4] + in[5] + in[6] + in[7];
    end
endmodule
module popcount_16bit (
    input [15:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = in[0] + in[1] + in[2] + in[3] + in[4] + in[5] + in[6] + in[7] +
              in[8] + in[9] + in[10] + in[11] + in[12] + in[13] + in[14] + in[15];
    end
endmodule
module popcount_32bit (
    input [31:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = in[0] + in[1] + in[2] + in[3] + in[4] + in[5] + in[6] + in[7] +
              in[8] + in[9] + in[10] + in[11] + in[12] + in[13] + in[14] + in[15] +
              in[16] + in[17] + in[18] + in[19] + in[20] + in[21] + in[22] + in[23] +
              in[24] + in[25] + in[26] + in[27] + in[28] + in[29] + in[30] + in[31];
    end
endmodule
