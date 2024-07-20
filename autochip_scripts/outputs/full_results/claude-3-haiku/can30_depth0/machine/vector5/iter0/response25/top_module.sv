module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] neg_a, neg_b, neg_c, neg_d, neg_e;
wire [4:0] pos_a, pos_b, pos_c, pos_d, pos_e;

// Generate the 5-bit vectors
assign neg_a = {5{~a}};
assign neg_b = {5{~b}};
assign neg_c = {5{~c}};
assign neg_d = {5{~d}};
assign neg_e = {5{~e}};

assign pos_a = {5{a}};
assign pos_b = {5{b}};
assign pos_c = {5{c}};
assign pos_d = {5{d}};
assign pos_e = {5{e}};

// Concatenate the 5-bit vectors into 25-bit vectors
wire [24:0] neg_vector = {neg_a, neg_b, neg_c, neg_d, neg_e};
wire [24:0] pos_vector = {pos_a, pos_b, pos_c, pos_d, pos_e};

// Compute the bitwise XOR
assign out = neg_vector ^ pos_vector;

endmodule
