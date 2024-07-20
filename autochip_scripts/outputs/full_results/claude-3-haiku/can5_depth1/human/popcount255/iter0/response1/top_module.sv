module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count in multiple stages
wire [31:0] stage1 [7:0];
wire [15:0] stage2 [15:0];
wire [7:0] stage3 [31:0];
wire [3:0] stage4 [63:0];
wire [1:0] stage5 [127:0];

// Stage 1: Count 1's in 8-bit chunks
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : gen_stage1
        assign stage1[i] = $countones(in[(i*32+31):(i*32)]);
    end
endgenerate

// Stage 2: Sum adjacent 8-bit chunks
genvar j;
generate
    for (j = 0; j < 16; j = j + 1) begin : gen_stage2
        assign stage2[j] = stage1[j*2] + stage1[j*2+1];
    end
endgenerate

// Stage 3: Sum adjacent 16-bit chunks
genvar k;
generate
    for (k = 0; k < 32; k = k + 1) begin : gen_stage3
        assign stage3[k] = stage2[k*2] + stage2[k*2+1];
    end
endgenerate

// Stage 4: Sum adjacent 32-bit chunks
genvar l;
generate
    for (l = 0; l < 64; l = l + 1) begin : gen_stage4
        assign stage4[l] = stage3[l*2] + stage3[l*2+1];
    end
endgenerate

// Stage 5: Sum adjacent 64-bit chunks
genvar m;
generate
    for (m = 0; m < 128; m = m + 1) begin : gen_stage5
        assign stage5[m] = stage4[m*2] + stage4[m*2+1];
    end
endgenerate

// Final stage: Sum the last two 128-bit chunks
always @(*) begin
    out = stage5[0] + stage5[1];
end

endmodule
