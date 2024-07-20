module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] neg_a, neg_b, neg_c, neg_d, neg_e;
    wire [24:0] pos_a, pos_b, pos_c, pos_d, pos_e;

    // Create the vector of 25 bits, where each bit corresponds to the negation of the input signal
    assign neg_a = {5{~a}};
    assign neg_b = {5{~b}};
    assign neg_c = {5{~c}};
    assign neg_d = {5{~d}};
    assign neg_e = {5{~e}};

    // Create the vector of 25 bits, where each bit corresponds to the input signal
    assign pos_a = {5{a}};
    assign pos_b = {5{b}};
    assign pos_c = {5{c}};
    assign pos_d = {5{d}};
    assign pos_e = {5{e}};

    // Compute the bitwise exclusive-or of the two 25-bit vectors
    assign out = neg_a ^ neg_b ^ neg_c ^ neg_d ^ neg_e ^ pos_a ^ pos_b ^ pos_c ^ pos_d ^ pos_e;

endmodule
