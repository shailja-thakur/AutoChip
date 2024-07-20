module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire wire1, wire2;

    assign wire1 = a & b;
    assign wire2 = c | d;
    assign q = wire1 & wire2;

endmodule
