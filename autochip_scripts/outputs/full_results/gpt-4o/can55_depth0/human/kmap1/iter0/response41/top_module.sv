module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Sum of Minterms: out = a + b'c

    assign out = a | (~b & c);

endmodule
