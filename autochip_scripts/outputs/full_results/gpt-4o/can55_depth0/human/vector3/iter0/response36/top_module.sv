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
    
    // Create a 30-bit concatenation of all input vectors followed by two 1 bits
    wire [31:0] concatenated;
    assign concatenated = {a, b, c, d, e, f, 2'b11};
    
    // Assign 8-bit chunks to the outputs
    assign w = concatenated[31:24];
    assign x = concatenated[23:16];
    assign y = concatenated[15:8];
    assign z = concatenated[7:0];

endmodule
