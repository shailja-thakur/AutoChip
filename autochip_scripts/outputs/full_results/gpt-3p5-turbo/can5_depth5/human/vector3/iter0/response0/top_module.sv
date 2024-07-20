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

    wire [29:0] input_concatenated;
    wire [31:0] output_concatenated;

    // Concatenate input vectors
    assign input_concatenated = {a, b, c, d, e, f};

    // Create output_vectors by splitting the concatenated input vectors
    assign {output_concatenated, w, x, y, z} = {input_concatenated, 2'b11};

endmodule
