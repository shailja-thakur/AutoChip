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

    wire [33:0] concatenated_input;

    // Concatenate inputs and add two 1 bits at the LSB positions
    assign concatenated_input = {a, b, c, d, e, f, 2'b11};

    // Split the concatenated result into the output vectors
    assign w = concatenated_input[33:26];
    assign x = concatenated_input[25:18];
    assign y = concatenated_input[17:10];
    assign z = concatenated_input[9:2];

endmodule
