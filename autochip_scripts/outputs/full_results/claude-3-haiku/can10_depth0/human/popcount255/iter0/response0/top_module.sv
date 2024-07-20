module top_module (
    input [254:0] in,
    output reg [7:0] out
);

wire [7:0] count_1, count_2, count_3, count_4;

// Stage 1: Count 1s in groups of 64 bits
count_64bits stage1_0 (.in(in[63:0]), .out(count_1[7:0]));
count_64bits stage1_1 (.in(in[127:64]), .out(count_1[15:8]));
count_64bits stage1_2 (.in(in[191:128]), .out(count_1[23:16]));
count_64bits stage1_3 (.in(in[254:192]), .out(count_1[31:24]));

// Stage 2: Sum the counts from stage 1
// Use a binary tree adder to sum the 4 counts
wire [15:0] sum_12, sum_34;
adder8 adder_12 (.a(count_1[15:8]), .b(count_1[7:0]), .sum(sum_12));
adder8 adder_34 (.a(count_1[31:24]), .b(count_1[23:16]), .sum(sum_34));
adder16 adder_final (.a(sum_12), .b(sum_34), .sum(count_2));

// Stage 3: Sum the counts from stage 2
adder8 adder_3_0 (.a(count_2[7:0]), .b(count_2[15:8]), .sum(count_3));

// Stage 4: Sum the final count
adder8 adder_4_0 (.a(count_3[7:0]), .b(8'b0), .sum(out));

endmodule
module count_64bits (
    input [63:0] in,
    output reg [7:0] out
);

integer i;
always @(*) begin
    out = 0;
    for (i = 0; i < 64; i = i + 1) begin
        out = out + in[i];
    end
end

endmodule
module adder8 (
    input [7:0] a,
    input [7:0] b,
    output [7:0] sum
);

assign sum = a + b;

endmodule
module adder16 (
    input [15:0] a,
    input [15:0] b,
    output [15:0] sum
);

assign sum = a + b;

endmodule
