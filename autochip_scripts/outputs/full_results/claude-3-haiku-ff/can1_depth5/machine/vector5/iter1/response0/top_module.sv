module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] xor_vec, and_vec;

// Create the 5-bit vector for each input signal
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Compute the bitwise exclusive-or of the two 25-bit vectors
assign xor_vec = {a_vec, b_vec, c_vec, d_vec, e_vec} ^ ~{a_vec, b_vec, c_vec, d_vec, e_vec};

// Assign the result to the output
assign out = xor_vec;

endmodule
