module top_module(
    input a,
    input b,
    input c,
    output out
);

    // Define internal wires and gates
    wire w1, w2, w3;

    // Implement logic gates
    assign w1 = a & b & ~c;
    assign w2 = a & b & c;
    assign w3 = a | b | c;

    // Output
    assign out = w1 | w2 | w3;

endmodule
