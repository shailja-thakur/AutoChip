module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    // Assign the selected bit from the input vector to the output
    assign out = in[sel];

endmodule
