module top_module(
    input a,
    input b,
    output out
);

    // Implement the logic gates
    wire or_out;
    or gate1 (or_out, a, b);
    not gate2 (out, or_out);

endmodule
