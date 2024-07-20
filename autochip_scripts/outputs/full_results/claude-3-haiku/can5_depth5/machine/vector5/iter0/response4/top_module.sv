module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] neg_a, neg_b, neg_c, neg_d, neg_e;
wire [24:0] pos_a_b_c_d_e;

assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

assign neg_a = {25{~a}};
assign neg_b = {25{~b}};
assign neg_c = {25{~c}};
assign neg_d = {25{~d}};
assign neg_e = {25{~e}};

assign pos_a_b_c_d_e = {5{a,b,c,d,e}};

assign out = neg_a ^ neg_b ^ neg_c ^ neg_d ^ neg_e ^ pos_a_b_c_d_e;

endmodule
