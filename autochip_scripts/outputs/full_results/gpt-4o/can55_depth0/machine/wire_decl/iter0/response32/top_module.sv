module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n 
    );

    // Intermediate wires
    wire w1;
    wire w2;

    // Assign w1 to logical AND of a and b
    assign w1 = a & b;

    // Assign w2 to logical AND of c and d
    assign w2 = c & d;

    // Assign out to logical OR of w1 and w2
    assign out = w1 | w2;

    // Assign out_n to logical NOT of out
    assign out_n = ~out;

endmodule
