module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire w1, w2; // declaring wires

    assign w1 = a & b; // w1 is AND of a and b
    assign w2 = c & d; // w2 is AND of c and d
    assign out = w1 | w2; // out is OR of w1 and w2
    assign out_n = ~out; // out_n is NOT of out

endmodule
