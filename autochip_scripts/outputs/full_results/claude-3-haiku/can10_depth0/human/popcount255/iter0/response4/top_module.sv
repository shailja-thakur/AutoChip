module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Use a tree-based reduction to count the population
wire [7:0] count_1, count_2, count_3, count_4, count_5, count_6, count_7, count_8;

// Level 1: Count 1s in each 32-bit group
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        popcount32 pc32 (
            .in(in[32*i+31:32*i]),
            .out(count_1[i])
        );
    end
endgenerate

// Level 2: Sum the 32-bit counts
assign count_2[0] = count_1[0] + count_1[1];
assign count_2[1] = count_1[2] + count_1[3];
assign count_2[2] = count_1[4] + count_1[5];
assign count_2[3] = count_1[6] + count_1[7];

// Level 3: Sum the 64-bit counts
assign count_3[0] = count_2[0] + count_2[1];
assign count_3[1] = count_2[2] + count_2[3];

// Level 4: Sum the 128-bit counts
assign count_4 = count_3[0] + count_3[1];

// Level 5: Sum the 256-bit counts
assign count_5 = count_4;

always @(*) begin
    out = count_5;
end

endmodule
module popcount32 (
    input [31:0] in,
    output reg [7:0] out
);

// Combinational logic to count the number of 1s in the 32-bit input
integer i;
always @(*) begin
    out = 0;
    for (i = 0; i < 32; i = i + 1) begin
        if (in[i]) out = out + 1;
    end
end

endmodule
