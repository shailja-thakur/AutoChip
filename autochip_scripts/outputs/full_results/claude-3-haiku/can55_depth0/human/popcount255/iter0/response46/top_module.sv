module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count using a tree-based approach
wire [31:0] count_stage1 [7:0];
wire [15:0] count_stage2 [7:0];
wire [7:0] count_stage3 [7:0];

// Stage 1: Count 1's in 8 groups of 32-bits
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        popcount #(32) pc1 (
            .in(in[(i*32)+31:(i*32)]),
            .out(count_stage1[i])
        );
    end
endgenerate

// Stage 2: Count 1's in 8 groups of 16-bits
generate
    for (i = 0; i < 8; i = i + 1) begin
        popcount #(16) pc2 (
            .in({count_stage1[i][31:16], count_stage1[i][15:0]}),
            .out(count_stage2[i])
        );
    end
endgenerate

// Stage 3: Count 1's in 8 groups of 8-bits
generate
    for (i = 0; i < 8; i = i + 1) begin
        popcount #(8) pc3 (
            .in({count_stage2[i][15:8], count_stage2[i][7:0]}),
            .out(count_stage3[i])
        );
    end
endgenerate

// Final output
always @(*) begin
    out = count_stage3[0] + count_stage3[1] + count_stage3[2] + count_stage3[3] +
          count_stage3[4] + count_stage3[5] + count_stage3[6] + count_stage3[7];
end

// Submodule: Population counter for N-bit input
module popcount #(
    parameter N = 8
) (
    input [N-1:0] in,
    output [C_WIDTH-1:0] out
);

    localparam C_WIDTH = $clog2(N + 1);

    reg [C_WIDTH-1:0] count;
    integer j;

    always @(*) begin
        count = 0;
        for (j = 0; j < N; j = j + 1) begin
            if (in[j]) count = count + 1;
        end
    end

    assign out = count;

endmodule
