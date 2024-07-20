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
    wire [29:0] concatenated_input;
    wire [31:0] all_concatenated;

    // Concatenate the input vectors
    assign concatenated_input = {a, b, c, d, e, f};
    
    // Concatenate the concatenated input with two 1 bits at the LSB positions
    assign all_concatenated = {concatenated_input, 2'b11};

    // Split the 32-bit output into four 8-bit outputs
    assign w = all_concatenated[31:24];
    assign x = all_concatenated[23:16];
    assign y = all_concatenated[15:8];
    assign z = all_concatenated[7:0];

endmodule
