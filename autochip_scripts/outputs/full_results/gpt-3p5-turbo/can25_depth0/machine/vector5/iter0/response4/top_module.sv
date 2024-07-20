module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] a_vec;
    wire [4:0] b_vec;
    wire [4:0] c_vec;
    wire [4:0] d_vec;
    wire [4:0] e_vec;

    assign a_vec = 5'b11111 ^ 5'b00000;
    assign b_vec = 5'b11111 ^ 5'b00000;
    assign c_vec = 5'b11111 ^ 5'b00000;
    assign d_vec = 5'b11111 ^ 5'b00000;
    assign e_vec = 5'b11111 ^ 5'b00000;

    wire [24:0] xor_vec;
    assign xor_vec = {a_vec, b_vec, c_vec, d_vec, e_vec} ^ {a, b, c, d, e};

    assign out = xor_vec;

endmodule
