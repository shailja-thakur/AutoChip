module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
    wire [24:0] inv_a, inv_b, inv_c, inv_d, inv_e, concat_a_b_c_d_e;

    assign a_vec = {5{a}};
    assign b_vec = {5{b}};
    assign c_vec = {5{c}};
    assign d_vec = {5{d}};
    assign e_vec = {5{e}};

    assign inv_a = ~a_vec;
    assign inv_b = ~b_vec;
    assign inv_c = ~c_vec;
    assign inv_d = ~d_vec;
    assign inv_e = ~e_vec;

    assign concat_a_b_c_d_e = {a_vec, b_vec, c_vec, d_vec, e_vec};

    assign out = inv_a ^ inv_b ^ inv_c ^ inv_d ^ inv_e ^ concat_a_b_c_d_e;

endmodule
