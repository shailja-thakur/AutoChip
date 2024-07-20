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

    // Temporary wire to hold the concatenation result
    wire [38:0] concat_result;
    
    // Concatenate the inputs
    assign concat_result = {a, b, c, d, e, f, 2'b11};
    
    // Split the concatenated result into four 8-bit outputs
    assign w = concat_result[7:0];
    assign x = concat_result[15:8];
    assign y = concat_result[23:16];
    assign z = concat_result[31:24];
    
endmodule
