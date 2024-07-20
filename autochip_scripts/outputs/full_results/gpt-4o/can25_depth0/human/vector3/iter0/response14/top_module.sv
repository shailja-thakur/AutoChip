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

    wire [31:0] concatenated_output;
    
    // Concatenate the input vectors and append two '1' bits
    assign concatenated_output = {a, b, c, d, e, f, 2'b11};
    
    // Split the concatenated output into four 8-bit output vectors
    assign w = concatenated_output[31:24];
    assign x = concatenated_output[23:16];
    assign y = concatenated_output[15:8];
    assign z = concatenated_output[7:0];

endmodule
