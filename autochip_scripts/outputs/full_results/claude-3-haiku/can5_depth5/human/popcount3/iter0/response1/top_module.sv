module top_module (
    input [2:0] in,
    output [1:0] out
);

    wire [1:0] count1, count2, count3;

    // First stage: Count bits in each 1-bit position
    assign count1 = (in[0]) ? 2'd1 : 2'd0;
    assign count2 = (in[1]) ? 2'd1 : 2'd0;
    assign count3 = (in[2]) ? 2'd1 : 2'd0;

    // Second stage: Sum the counts
    assign out = count1 + count2 + count3;

endmodule
