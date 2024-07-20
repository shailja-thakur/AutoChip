module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] count_1, count_2;

// First stage: Count the number of 1s in each 1-bit group
assign count_1[0] = in[0];
assign count_1[1] = in[1] + in[2];

// Second stage: Add the counts from the first stage
assign out = count_1[0] + count_1[1];

endmodule
