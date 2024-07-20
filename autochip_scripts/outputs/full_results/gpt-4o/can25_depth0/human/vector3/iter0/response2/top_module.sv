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
    wire [31:0] concat_result; // 30 bits input concatenation + 2 bits '1'

    // Concatenate the inputs and then add the two 1s at the LSB positions
    assign concat_result = {a, b, c, d, e, f, 2'b11};
    
    // Split the 32-bit result into four 8-bit output vectors
    assign w = concat_result[31:24];
    assign x = concat_result[23:16];
    assign y = concat_result[15:8];
    assign z = concat_result[7:0];

endmodule
