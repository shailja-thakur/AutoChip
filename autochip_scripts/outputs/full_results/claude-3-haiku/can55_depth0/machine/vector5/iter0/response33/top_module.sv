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

// Generate 5-bit vectors from input signals
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Construct the first 25-bit vector
assign first_vec = ~{a_vec, b_vec, c_vec, d_vec, e_vec};

// Construct the second 25-bit vector
assign second_vec = {5{a,b,c,d,e}};

// Compute the bitwise exclusive-OR of the two vectors
assign out = first_vec ^ second_vec;

endmodule
