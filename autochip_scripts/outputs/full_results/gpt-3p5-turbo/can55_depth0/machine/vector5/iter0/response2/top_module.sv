module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] vector_1;
    wire [4:0] vector_2;
    wire [24:0] xor_result;

    // First vector
    assign vector_1[4:0] = ~{a, a, a, a, a} ^ ~{b, b, b, b, b} ^ ~{c, c, c, c, c} ^ ~{d, d, d, d, d} ^ ~{e, e, e, e, e};

    // Second vector
    assign vector_2[4:0] = {a, a, a, a, a} ^ {b, b, b, b, b} ^ {c, c, c, c, c} ^ {d, d, d, d, d} ^ {e, e, e, e, e};

    // XOR operation
    assign xor_result = vector_1 ^ vector_2;

    // Assign output
    assign out = xor_result;

endmodule
