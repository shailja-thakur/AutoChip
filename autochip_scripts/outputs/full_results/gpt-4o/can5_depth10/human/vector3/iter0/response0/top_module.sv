module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:8] y,
    output [7:8] z
);

    // Concatenate all the inputs and append two '1' bits at the end
    wire [31:0] concatenated;
    assign concatenated = {a, b, c, d, e, f, 2'b11};

    // Assign the 8-bit segments to the outputs
    assign w = concatenated[31:24];
    assign x = concatenated[23:16];
    assign y = concatenated[15:8];
    assign z = concatenated[7:0];

endmodule
