module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);
    wire [29:0] input_concat;  // Concatenated input vector
    wire [31:0] output_concat;  // Concatenated output vector

    // Concatenate input vectors
    assign input_concat = {a, b, c, d, e, f};

    // Concatenated output vector followed by two 1 bits
    assign output_concat = {input_concat, 2'b11};

    // Split the concatenated output vector into individual output vectors
    assign {w, x, y, z} = output_concat;

endmodule
