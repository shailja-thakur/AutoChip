module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] not_a, not_b, not_c, not_d, not_e, xor_vec;

assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

assign not_a = ~a_vec;
assign not_b = ~b_vec;
assign not_c = ~c_vec;
assign not_d = ~d_vec;
assign not_e = ~e_vec;

assign xor_vec = not_a ^ not_b ^ not_c ^ not_d ^ not_e ^ {5{a,b,c,d,e}};

assign out = xor_vec;

endmodule
