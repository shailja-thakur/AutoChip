module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Intermediate wires
    wire w1, w2, w3, w4, w5, w6;

    // First level of logic
    assign w1 = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & b & c & ~d) | (a & b & c & ~d);

    // Second level of logic
    assign w2 = ~w1 | (c & d);

    // Third level of logic
    assign w3 = ~w2 | (a & b);

    // Fourth level of logic
    assign w4 = ~w3 | (a & ~b & c) | (~c & d);

    // Fifth level of logic
    assign w5 = ~w4 | (~a & c & ~d);

    // Final output
    assign q = ~w5;

endmodule
