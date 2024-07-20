module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    // Assign the output by selecting the appropriate 4-bit slice from the input vector based on sel
    assign out = in[sel*4 +: 4];
endmodule
