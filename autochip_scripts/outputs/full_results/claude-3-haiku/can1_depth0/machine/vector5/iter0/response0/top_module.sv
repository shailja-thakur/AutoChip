module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] first_vec, second_vec;

// Generate the 5-bit vectors
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Generate the first 25-bit vector
assign first_vec = ~{a_vec, b_vec, c_vec, d_vec, e_vec};

// Generate the second 25-bit vector
assign second_vec = {5{a,b,c,d,e}};

// Compute the bitwise XOR
assign out = first_vec ^ second_vec;

endmodule
