module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] not_a, not_b, not_c, not_d, not_e;
wire [4:0] a_bits, b_bits, c_bits, d_bits, e_bits;

assign not_a = {5{~a}};
assign not_b = {5{~b}};
assign not_c = {5{~c}};
assign not_d = {5{~d}};
assign not_e = {5{~e}};

assign a_bits = {5{a}};
assign b_bits = {5{b}};
assign c_bits = {5{c}};
assign d_bits = {5{d}};
assign e_bits = {5{e}};

assign out = not_a ^ not_b ^ not_c ^ not_d ^ not_e ^ a_bits ^ b_bits ^ c_bits ^ d_bits ^ e_bits;

endmodule
