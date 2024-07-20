module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    // Assign the output as a 4-bit slice of the input.
    assign out = in[sel * 4 +: 4];
endmodule
