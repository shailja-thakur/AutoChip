module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Use a tree-based population count approach
wire [7:0] count_layer_1 [31:0];
wire [7:0] count_layer_2 [15:0];
wire [7:0] count_layer_3 [7:0];
wire [7:0] count_layer_4 [3:0];
wire [7:0] count_layer_5 [1:0];

genvar i;

// Layer 1: Count the population in each 8-bit chunk
generate
    for (i = 0; i < 32; i = i + 1) begin
        popcount_8bit pc1(
            .in(in[(i*8)+7:i*8]),
            .out(count_layer_1[i])
        );
    end
endgenerate

// Layer 2: Sum the 8-bit population counts in pairs
generate
    for (i = 0; i < 16; i = i + 1) begin
        adder_8bit a2(
            .a(count_layer_1[i*2]),
            .b(count_layer_1[i*2+1]),
            .sum(count_layer_2[i])
        );
    end
endgenerate

// Layer 3: Sum the 8-bit population counts in pairs
generate
    for (i = 0; i < 8; i = i + 1) begin
        adder_8bit a3(
            .a(count_layer_2[i*2]),
            .b(count_layer_2[i*2+1]),
            .sum(count_layer_3[i])
        );
    end
endgenerate

// Layer 4: Sum the 8-bit population counts in pairs
generate
    for (i = 0; i < 4; i = i + 1) begin
        adder_8bit a4(
            .a(count_layer_3[i*2]),
            .b(count_layer_3[i*2+1]),
            .sum(count_layer_4[i])
        );
    end
endgenerate

// Layer 5: Sum the 8-bit population counts in pairs
adder_8bit a5(
    .a(count_layer_4[0]),
    .b(count_layer_4[1]),
    .sum(count_layer_5[0])
);
adder_8bit a6(
    .a(count_layer_4[2]),
    .b(count_layer_4[3]),
    .sum(count_layer_5[1])
);

// Final adder to get the total population count
adder_8bit a7(
    .a(count_layer_5[0]),
    .b(count_layer_5[1]),
    .sum(out)
);

// Submodules
module popcount_8bit (
    input [7:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = $countones(in);
    end
endmodule
module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] sum
);
    always @(*) begin
        sum = a + b;
    end
endmodule
