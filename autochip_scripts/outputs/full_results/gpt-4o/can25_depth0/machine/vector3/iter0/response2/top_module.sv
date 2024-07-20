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
    // Concatenation of inputs a, b, c, d, e, f with 2'b11
    wire [31:0] concatenation;
    assign concatenation = {a, b, c, d, e, f, 2'b11};
    
    // Assigning concatenation bits to outputs w, x, y, z
    assign w = concatenation[31:24];
    assign x = concatenation[23:16];
    assign y = concatenation[15:8];
    assign z = concatenation[7:0];
    
endmodule
