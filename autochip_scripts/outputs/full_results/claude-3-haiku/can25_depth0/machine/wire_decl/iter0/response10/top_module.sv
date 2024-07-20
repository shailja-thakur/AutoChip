module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire w1, w2;

    // Assign the logical AND of a and b to w1
    assign w1 = a & b;

    // Assign the logical AND of c and d to w2
    assign w2 = c & d;

    // Assign the logical OR of w1 and w2 to out
    assign out = w1 | w2;

    // Assign the logical NOT of out to out_n
    assign out_n = ~out;

endmodule
