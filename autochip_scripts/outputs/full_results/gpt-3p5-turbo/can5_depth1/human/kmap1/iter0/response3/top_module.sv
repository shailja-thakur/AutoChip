module top_module(
    input a, 
    input b,
    input c,
    output out
);
    wire w1, w2, w3, w4, w5;

    // Implementing the truth table
    assign w1 = (a & ~b & ~c);
    assign w2 = (a & b & ~c);
    assign w3 = (a & b & c);
    assign w4 = (~a & b & c);
    assign w5 = (a | b | c);

    // Assigning the output
    assign out = w1 | w2 | w3 | w4 | w5;
endmodule
