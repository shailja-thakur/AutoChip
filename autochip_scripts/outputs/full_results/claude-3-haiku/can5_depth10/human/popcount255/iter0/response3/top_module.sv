module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Use a tree-based population count algorithm
// Level 1: Count each group of 8 bits
wire [31:0] level1;
genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin
        assign level1[i] = ^in[8*i +: 8];
    end
endgenerate

// Level 2: Count each group of 4 level1 bits
wire [15:0] level2;
genvar j;
generate
    for (j = 0; j < 16; j = j + 1) begin
        assign level2[j] = ^level1[4*j +: 4];
    end
endgenerate

// Level 3: Count each group of 2 level2 bits
wire [7:0] level3;
genvar k;
generate
    for (k = 0; k < 8; k = k + 1) begin
        assign level3[k] = ^level2[2*k +: 2];
    end
endgenerate

// Final level: Combine the level3 bits
always @(*) begin
    out = level3;
end

endmodule
