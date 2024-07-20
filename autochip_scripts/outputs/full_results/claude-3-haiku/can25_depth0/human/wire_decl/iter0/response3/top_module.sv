module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and_ab, and_cd;

// First layer: Two AND gates
and (and_ab, a, b);
and (and_cd, c, d);

// Second layer: OR gate and NOT gate
or (out, and_ab, and_cd);
not (out_n, out);

endmodule
