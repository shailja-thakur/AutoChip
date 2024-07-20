module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    // Declare wires
    wire w1, w2;

    // Assign wires to the AND of the inputs
    assign w1 = a & b;
    assign w2 = c & d;

    // Assign output to OR of wires
    assign out = w1 | w2;

    // Assign out_n to the NOT of output
    assign out_n = ~out;

endmodule
