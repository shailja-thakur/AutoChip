module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Compute population count in four stages
wire [31:0] stage1 [7:0];
wire [15:0] stage2 [7:0];
wire [7:0]  stage3 [7:0];
wire [7:0]  stage4;

// Stage 1: Compute population count for each 32-bit group
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        popcount32 pc32 (
            .in(in[(i+1)*32-1:i*32]),
            .out(stage1[i])
        );
    end
endgenerate

// Stage 2: Compute population count for each 16-bit group
genvar j;
generate
    for (j = 0; j < 8; j = j + 1) begin
        adder16 a16 (
            .a(stage1[j][15:0]),
            .b(stage1[j][31:16]),
            .out(stage2[j])
        );
    end
endgenerate

// Stage 3: Compute population count for each 8-bit group
genvar k;
generate
    for (k = 0; k < 8; k = k + 1) begin
        adder8 a8 (
            .a(stage2[k][7:0]),
            .b(stage2[k][15:8]),
            .out(stage3[k])
        );
    end
endgenerate

// Stage 4: Compute final population count
adder8 a8_final (
    .a(stage3[0]),
    .b(stage3[1]),
    .c(stage3[2]),
    .d(stage3[3]),
    .e(stage3[4]),
    .f(stage3[5]),
    .g(stage3[6]),
    .h(stage3[7]),
    .out(stage4)
);

always @(*) begin
    out = stage4;
end

// Submodules
module popcount32 (
    input [31:0] in,
    output [31:0] out
);
    assign out = {1'b0, in[31:1]} + in[0];
endmodule
module adder16 (
    input [15:0] a,
    input [15:0] b,
    output [15:0] out
);
    assign out = a + b;
endmodule
module adder8 (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    input [7:0] e,
    input [7:0] f,
    input [7:0] g,
    input [7:0] h,
    output [7:0] out
);
    wire [7:0] temp1, temp2;
    assign temp1 = a + b + c + d;
    assign temp2 = e + f + g + h;
    assign out = temp1 + temp2;
endmodule
