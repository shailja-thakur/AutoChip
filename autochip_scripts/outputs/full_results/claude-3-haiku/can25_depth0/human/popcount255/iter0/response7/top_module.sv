module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count using a tree-like structure
wire [31:0] count_32;
wire [15:0] count_16;
wire [7:0] count_8;

// Level 1: Count 8-bit groups
genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin
        popcount_8 pc8 (
            .in(in[i*8 +: 8]),
            .out(count_32[i])
        );
    end
endgenerate

// Level 2: Count 16-bit groups
assign count_16[0] = count_32[0] + count_32[1];
assign count_16[1] = count_32[2] + count_32[3];
assign count_16[2] = count_32[4] + count_32[5];
assign count_16[3] = count_32[6] + count_32[7];
assign count_16[4] = count_32[8] + count_32[9];
assign count_16[5] = count_32[10] + count_32[11];
assign count_16[6] = count_32[12] + count_32[13];
assign count_16[7] = count_32[14] + count_32[15];
assign count_16[8] = count_32[16] + count_32[17];
assign count_16[9] = count_32[18] + count_32[19];
assign count_16[10] = count_32[20] + count_32[21];
assign count_16[11] = count_32[22] + count_32[23];
assign count_16[12] = count_32[24] + count_32[25];
assign count_16[13] = count_32[26] + count_32[27];
assign count_16[14] = count_32[28] + count_32[29];
assign count_16[15] = count_32[30] + count_32[31];

// Level 3: Count 32-bit groups
assign count_8[0] = count_16[0] + count_16[1];
assign count_8[1] = count_16[2] + count_16[3];
assign count_8[2] = count_16[4] + count_16[5];
assign count_8[3] = count_16[6] + count_16[7];
assign count_8[4] = count_16[8] + count_16[9];
assign count_8[5] = count_16[10] + count_16[11];
assign count_8[6] = count_16[12] + count_16[13];
assign count_8[7] = count_16[14] + count_16[15];

// Output the final count
always @* begin
    out = count_8;
end

// 8-bit population count module
module popcount_8 (
    input [7:0] in,
    output [0:0] out
);
    assign out = in[0] + in[1] + in[2] + in[3] + in[4] + in[5] + in[6] + in[7];
endmodule
