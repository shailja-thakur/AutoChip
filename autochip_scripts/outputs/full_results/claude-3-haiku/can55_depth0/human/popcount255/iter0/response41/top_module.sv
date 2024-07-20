module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Declare intermediate wires
wire [31:0] count_1, count_2, count_3, count_4, count_5, count_6, count_7, count_8;

// Level 1: Count the number of 1's in each 32-bit chunk
popcount_32 pc1 (.in(in[31:0]),   .out(count_1));
popcount_32 pc2 (.in(in[63:32]),  .out(count_2));
popcount_32 pc3 (.in(in[95:64]),  .out(count_3));
popcount_32 pc4 (.in(in[127:96]), .out(count_4));
popcount_32 pc5 (.in(in[159:128]),.out(count_5));
popcount_32 pc6 (.in(in[191:160]),.out(count_6));
popcount_32 pc7 (.in(in[223:192]),.out(count_7));
popcount_32 pc8 (.in(in[254:224]),.out(count_8));

// Level 2: Add the counts from the 32-bit chunks
wire [31:0] sum_1 = count_1 + count_2 + count_3 + count_4;
wire [31:0] sum_2 = count_5 + count_6 + count_7 + count_8;

// Level 3: Add the two 32-bit sums to get the final 8-bit output
always @(*) begin
    out = sum_1[7:0] + sum_2[7:0];
end

endmodule
module popcount_32 (
    input [31:0] in,
    output [31:0] out
);

assign out = {
    $countones(in[31:24]),
    $countones(in[23:16]),
    $countones(in[15:8]),
    $countones(in[7:0])
};

endmodule
