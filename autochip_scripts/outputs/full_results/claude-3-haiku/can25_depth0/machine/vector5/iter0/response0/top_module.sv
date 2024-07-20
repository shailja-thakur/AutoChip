module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_bits, b_bits, c_bits, d_bits, e_bits;
assign a_bits = {5{a}};
assign b_bits = {5{b}};
assign c_bits = {5{c}};
assign d_bits = {5{d}};
assign e_bits = {5{e}};

wire [24:0] inv_abcde, abcde;
assign inv_abcde = ~{a_bits, b_bits, c_bits, d_bits, e_bits};
assign abcde = {a_bits, b_bits, c_bits, d_bits, e_bits};

assign out = inv_abcde ^ abcde;

endmodule
