module top_module (
    input [99:0] in,
    output reg [99:0] out
);

    // Assign reversed bits to output
    always @(in)
        for (int i = 0; i < 100; i = i + 1)
            out[i] = in[99 - i];

endmodule
