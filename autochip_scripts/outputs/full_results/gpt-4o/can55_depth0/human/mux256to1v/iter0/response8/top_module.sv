module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // Assign the selected bits to the output
    assign out = in[sel*4 +: 4];

endmodule
