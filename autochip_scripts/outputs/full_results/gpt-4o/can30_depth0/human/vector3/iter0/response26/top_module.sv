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
    // Temporary variable to hold the concatenated vectors and the two additional 1-bits
    wire [31:0] concatenation;
    
    // Concatenate all input vectors and two 1-bits as LSB
    assign concatenation = {a, b, c, d, e, f, 2'b11};
    
    // Split the concatenated result into four 8-bit output vectors
    assign w = concatenation[31:24];
    assign x = concatenation[23:16];
    assign y = concatenation[15:8];
    assign z = concatenation[7:0];
endmodule
