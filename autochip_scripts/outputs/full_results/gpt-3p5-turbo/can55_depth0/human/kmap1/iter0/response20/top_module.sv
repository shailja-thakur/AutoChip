module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Declare internal wire for the circuit
    wire w1, w2, w3;

    // Generate the output based on the Karnaugh map
    assign out = ~a & ~b & ~c | ~a & ~b & c | ~a & b & c | a & b & c;

endmodule
