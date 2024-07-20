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

    // Concatenating the input vectors
    wire [29:0] input_concatenated;
    assign input_concatenated = {a, b, c, d, e, f};

    // Appending two 1 bits
    wire [31:0] output_concatenated;
    assign output_concatenated = {input_concatenated, 2'b11};

    // Splitting the concatenated input into output vectors
    assign {w, x, y, z} = output_concatenated;

endmodule
