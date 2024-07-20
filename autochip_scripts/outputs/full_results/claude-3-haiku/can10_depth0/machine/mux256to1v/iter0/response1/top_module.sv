module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // Calculate the starting index of the 4-bit block in the input vector (in)
    // based on the selection vector (sel)
    localparam START_INDEX = sel * 4;

    // Extract the 4-bit block from the input vector (in) starting from the calculated index
    assign out = in[START_INDEX+3:START_INDEX];

endmodule
