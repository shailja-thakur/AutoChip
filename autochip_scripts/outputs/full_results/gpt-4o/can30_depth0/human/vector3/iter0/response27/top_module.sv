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
    wire [31:0] concat_input;
    
    // Concatenate the input vectors and add two 1 bits at the LSB positions
    assign concat_input = {a, b, c, d, e, f, 2'b11};

    // Split the concatenated input into four 8-bit output vectors
    assign w = concat_input[31:24];
    assign x = concat_input[23:16];
    assign y = concat_input[15:8];
    assign z = concat_input[7:0];

endmodule
