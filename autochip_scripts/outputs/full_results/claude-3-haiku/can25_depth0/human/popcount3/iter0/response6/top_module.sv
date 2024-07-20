module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] count1, count2;

// First stage - count 1 bits in each group of 2 bits
assign count1[0] = in[0];
assign count1[1] = in[1] + in[2];

// Second stage - add the two partial counts
assign out = count1[0] + count1[1];

endmodule
