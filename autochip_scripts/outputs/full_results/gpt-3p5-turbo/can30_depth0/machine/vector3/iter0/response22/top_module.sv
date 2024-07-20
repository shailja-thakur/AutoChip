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

    wire [7:0] concat_input; // Wire for concatenation input
    wire [1:0] last_bit; // Wire for the last bit of the concatenation
    
    assign concat_input = {a[4], b[4], c[4], d[4], e[4], f[4], 2'b11};
    assign last_bit = concat_input[7:6];
    
    assign w = concat_input[7:0];
    assign x = concat_input[6:0];
    assign y = concat_input[5:0];
    assign z = {concat_input[4:0], last_bit};

endmodule
