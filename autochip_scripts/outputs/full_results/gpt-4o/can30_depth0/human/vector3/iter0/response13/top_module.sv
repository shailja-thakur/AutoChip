module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:8] x,
    output [7:8] y,
    output [7:8] z
);
    // Concatenate the input vectors and add two '1' bits at the LSB positions
    wire [31:0] combined = {a, b, c, d, e, f, 2'b11};

    // Split the combined vector into output vectors
    assign w = combined[31:24];
    assign x = combined[23:16];
    assign y = combined[15:8];
    assign z = combined[7:0];
endmodule
