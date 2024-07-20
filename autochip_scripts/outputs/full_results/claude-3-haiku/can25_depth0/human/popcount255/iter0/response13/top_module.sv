module top_module (
    input [254:0] in,
    output reg [7:0] out
);

wire [31:0] count_stage1 [7:0];
wire [15:0] count_stage2 [7:0];
wire [7:0] count_stage3;

// Stage 1: Count 1s in each 32-bit chunk
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        popcnt32 pc32 (
            .in(in[(i*32+31):(i*32)]),
            .out(count_stage1[i])
        );
    end
endgenerate

// Stage 2: Sum up the 32-bit counts in each 64-bit group
genvar j;
generate
    for (j = 0; j < 8; j = j + 1) begin
        assign count_stage2[j*2] = count_stage1[j*2] + count_stage1[j*2+1][15:0];
        assign count_stage2[j*2+1] = count_stage1[j*2+1][31:16];
    end
endgenerate

// Stage 3: Sum up the 16-bit counts
assign count_stage3 = count_stage2[0] + count_stage2[1] +
                     count_stage2[2] + count_stage2[3] +
                     count_stage2[4] + count_stage2[5] +
                     count_stage2[6] + count_stage2[7];

always @(*) begin
    out = count_stage3;
end

// 32-bit population count module
module popcnt32 (
    input [31:0] in,
    output [31:0] out
);

integer i;
always @(*) begin
    out = 0;
    for (i = 0; i < 32; i = i + 1) begin
        out = out + in[i];
    end
end
endmodule
