module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] not_a_vec, not_b_vec, not_c_vec, not_d_vec, not_e_vec;
wire [24:0] and_vec;

assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

assign not_a_vec = ~{5{a}};
assign not_b_vec = ~{5{b}};
assign not_c_vec = ~{5{c}};
assign not_d_vec = ~{5{d}};
assign not_e_vec = ~{5{e}};

assign and_vec = {5{a,b,c,d,e}};

assign out = not_a_vec ^ not_b_vec ^ not_c_vec ^ not_d_vec ^ not_e_vec ^ and_vec;

endmodule
