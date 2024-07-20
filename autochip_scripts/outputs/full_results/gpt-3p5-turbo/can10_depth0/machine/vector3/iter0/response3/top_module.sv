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

    wire [7:0] concat_input;
    wire [1:0] last_bit;

    assign concat_input = {a, b, c, d, e, f};
    assign last_bit = 2'b11;

    assign w = {concat_input, last_bit};
    assign x = {concat_input, last_bit};
    assign y = {concat_input, last_bit};
    assign z = {concat_input, last_bit};

endmodule
