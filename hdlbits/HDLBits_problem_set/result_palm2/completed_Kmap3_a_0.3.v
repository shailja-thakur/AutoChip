module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    // OR gate 1
    xor1 (out, a, b);

    // OR gate 2
    xor2 (out, c, d);

    // AND gate 1
    and1 (out, xor1, xor2);

endmodule