module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] vector1, vector2;

assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

assign vector1 = ~{a_vec, b_vec, c_vec, d_vec, e_vec};
assign vector2 = {5{a,b,c,d,e}};

assign out = vector1 ^ vector2;

endmodule
