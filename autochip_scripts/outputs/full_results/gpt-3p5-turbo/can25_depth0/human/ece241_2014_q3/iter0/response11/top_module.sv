module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire f0, f1, f2, f3, f4;

    // 2-to-1 multiplexers
    mux2to1 m1 (.a(c), .b(d), .sel(b), .out(f0));
    mux2to1 m2 (.a(c), .b(~d), .sel(b), .out(f1));
    mux2to1 m3 (.a(c), .b(~d), .sel(a), .out(f2));
    mux2to1 m4 (.a(~c), .b(d), .sel(a), .out(f3));
    mux2to1 m5 (.a(c), .b(d), .sel(a), .out(f4));

    // 4-to-1 multiplexer
    mux4to1 m6 (.a(f1), .b(f2), .c(f3), .d(f4), .sel({a,b}), .out(mux_in));

endmodule
module mux2to1 (
    input a,
    input b,
    input sel,
    output out
);

    wire not_sel;

    not n1 (.a(sel), .out(not_sel));
    and a1 (.a(a), .b(not_sel), .out(out));
    and a2 (.a(b), .b(sel), .out(out));

endmodule
module mux4to1 (
    input a,
    input b,
    input c,
    input d,
    input [1:0] sel,
    output out
);

    wire not_sel0, not_sel1;

    not n1 (.a(sel[0]), .out(not_sel0));
    not n2 (.a(sel[1]), .out(not_sel1));
    and a1 (.a(a), .b(not_sel0), .b(not_sel1), .out(out));
    and a2 (.a(b), .b(sel[0]), .b(not_sel1), .out(out));
    and a3 (.a(c), .b(not_sel0), .b(sel[1]), .out(out));
    and a4 (.a(d), .b(sel[0]), .b(sel[1]), .out(out));

endmodule
