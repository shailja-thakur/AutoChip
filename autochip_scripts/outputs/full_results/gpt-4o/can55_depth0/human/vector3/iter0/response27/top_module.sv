module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:8] x,
    output [7:0] y,
    output [7:0] z
);
    // Concatenate the inputs and append two 1 bits
    wire [31:0] concatenated_bits = {a, b, c, d, e, f, 2'b11};
    
    assign w = concatenated_bits[31:24];
    assign x = concatenated_bits[23:16];
    assign y = concatenated_bits[15:8];
    assign z = concatenated_bits[7:0];

endmodule
