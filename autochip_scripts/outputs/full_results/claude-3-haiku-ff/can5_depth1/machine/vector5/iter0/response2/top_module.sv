module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_inv, b_inv, c_inv, d_inv, e_inv;
wire [4:0] a_direct, b_direct, c_direct, d_direct, e_direct;

// Inverse value vectors
assign a_inv = {5{~a}};
assign b_inv = {5{~b}};
assign c_inv = {5{~c}};
assign d_inv = {5{~d}};
assign e_inv = {5{~e}};

// Direct value vectors
assign a_direct = {5{a}};
assign b_direct = {5{b}};
assign c_direct = {5{c}};
assign d_direct = {5{d}};
assign e_direct = {5{e}};

// Combine the vectors and compute the XOR
assign out = (a_inv ^ b_inv ^ c_inv ^ d_inv ^ e_inv) ^ (a_direct ^ b_direct ^ c_direct ^ d_direct ^ e_direct);

endmodule
