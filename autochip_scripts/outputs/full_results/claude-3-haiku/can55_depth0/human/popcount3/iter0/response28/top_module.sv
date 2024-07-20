module top_module (
    input [2:0] in,
    output [1:0] out
);

    wire [1:0] count_1, count_2;

    // Count the number of 1's in the least significant 2 bits
    assign count_1 = (in[0] ? 1'b1 : 1'b0) + (in[1] ? 1'b1 : 1'b0);

    // Count the number of 1's in the most significant bit
    assign count_2 = in[2] ? 1'b1 : 1'b0;

    // Combine the counts
    assign out = count_1 + count_2;

endmodule
