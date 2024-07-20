module top_module(
    input a,
    input b,
    input c,
    output out
);
    // Implementing the truth table using logical operators
    // to get the desired output
    
    // Intermediate signals
    wire w1, w2, w3, w4;

    // Intermediate and final outputs
    output out_reg;

    // Logic gates to implement the circuit
    assign w1 = ~a & ~b & ~c;
    assign w2 = a & ~b & c;
    assign w3 = a & b & c;
    assign w4 = ~a & ~b & c;

    // Final output
    assign out_reg = w1 | w2 | w3 | w4;

    // Registor connecting the output
    assign out = out_reg;

endmodule
