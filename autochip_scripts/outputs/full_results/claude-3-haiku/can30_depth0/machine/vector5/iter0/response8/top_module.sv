module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] bit_not_vec, bit_and_vec;

// Create the vector of 5 bits, where each bit is equal to the corresponding input signal
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Create the bit-wise NOT vector
assign bit_not_vec = ~{a_vec, b_vec, c_vec, d_vec, e_vec};

// Create the bit-wise AND vector
assign bit_and_vec = {5{a,b,c,d,e}};

// Compute the final output by taking the XOR of the two vectors
assign out = bit_not_vec ^ bit_and_vec;

endmodule
