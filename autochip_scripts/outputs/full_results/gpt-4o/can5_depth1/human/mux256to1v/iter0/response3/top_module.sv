module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    // Use the select value to extract the appropriate 4-bit segment from the input
    assign out = in[sel*4 +: 4];

endmodule
