module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // the starting index of the 4-bit block
    wire [9:0] start_index;
    assign start_index = {sel, 2'b00};

    // extract the 4-bit block from the input vector
    assign out = in[start_index+3 -: 4];

endmodule
