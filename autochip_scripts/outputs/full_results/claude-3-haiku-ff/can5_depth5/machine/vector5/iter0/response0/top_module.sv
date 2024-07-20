module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] inverted_vec, original_vec;

assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

assign inverted_vec = ~{a_vec, b_vec, c_vec, d_vec, e_vec};
assign original_vec = {5{a,b,c,d,e}};

assign out = inverted_vec ^ original_vec;

endmodule
