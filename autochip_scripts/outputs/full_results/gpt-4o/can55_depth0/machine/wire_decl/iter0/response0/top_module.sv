module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    // Declare wires
    wire w1;
    wire w2;

    // Assign wires w1 and w2
    assign w1 = a & b;
    assign w2 = c & d;

    // Assign outputs out and out_n
    assign out = w1 | w2;
    assign out_n = ~out;

endmodule
