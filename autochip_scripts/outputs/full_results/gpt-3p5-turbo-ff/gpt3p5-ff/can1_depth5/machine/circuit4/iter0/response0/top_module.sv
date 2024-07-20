module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    or_gate or1 (.a(b), .b(c), .q(q));

endmodule
module or_gate (
    input a,
    input b,
    output q
);

    assign q = a | b;

endmodule
