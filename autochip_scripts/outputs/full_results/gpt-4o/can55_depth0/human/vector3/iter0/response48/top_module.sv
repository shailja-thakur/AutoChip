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
    wire [29:0] concatenated_input;
    wire [31:0] concatenated_with_padding;
    
    // Concatenate all inputs to form 30-bit value
    assign concatenated_input = {a, b, c, d, e, f};
    
    // Add two 1's in LSB positions to form 32-bit value
    assign concatenated_with_padding = {concatenated_input, 2'b11};
    
    // Split the 32-bit value into four 8-bit output vectors
    assign w = concatenated_with_padding[31:24];
    assign x = concatenated_with_padding[23:16];
    assign y = concatenated_with_padding[15:8];
    assign z = concatenated_with_padding[7:0];

endmodule
