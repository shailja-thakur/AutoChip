module top_module(
    input a,
    input b,
    output out
);
    not u1(
        .a(a | b),
        .out(out)
    );
endmodule
