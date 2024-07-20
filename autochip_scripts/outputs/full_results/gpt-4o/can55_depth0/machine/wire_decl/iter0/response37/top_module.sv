module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);
    wire w1;
    wire w2;

    // Assign w1 to the logical AND of inputs a and b
    assign w1 = a & b;

    // Assign w2 to the logical AND of inputs c and d
    assign w2 = c & d;

    // Assign out to the logical OR of wires w1 and w2
    assign out = w1 | w2;

    // Assign out_n to the logical NOT of the output out
    assign out_n = ~out;
endmodule
