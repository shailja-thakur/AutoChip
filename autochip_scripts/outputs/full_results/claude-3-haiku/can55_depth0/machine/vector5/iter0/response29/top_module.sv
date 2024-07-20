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

// Generate the 5-bit vectors
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Compute the bitwise XOR of the two 25-bit vectors
assign xor_vec = ~{a_vec, b_vec, c_vec, d_vec, e_vec};

// Compute the 25-bit vector with 1s where the inputs are 1
assign and_vec = {5{a,b,c,d,e}};

// Output the final result
assign out = xor_vec ^ and_vec;

endmodule
