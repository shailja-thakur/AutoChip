module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire w1, w2;

    // AND gates
    assign w1 = a & b;
    assign w2 = c & d;

    // OR gate
    assign out = w1 | w2;

    // NOT gate
    assign out_n = ~out;

endmodule
