module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] not_a, not_b, not_c, not_d, not_e;
    wire [4:0] and_a, and_b, and_c, and_d, and_e;

    // Compute the complement of each input signal
    assign not_a = {5{~a}};
    assign not_b = {5{~b}};
    assign not_c = {5{~c}};
    assign not_d = {5{~d}};
    assign not_e = {5{~e}};

    // Compute the 25-bit vector with 1s where the input signal is 1
    assign and_a = {5{a}};
    assign and_b = {5{b}};
    assign and_c = {5{c}};
    assign and_d = {5{d}};
    assign and_e = {5{e}};

    // Compute the final output
    assign out = not_a ^ not_b ^ not_c ^ not_d ^ not_e ^ and_a ^ and_b ^ and_c ^ and_d ^ and_e;

endmodule
