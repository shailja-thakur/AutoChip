module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire intermediate_1;
    wire intermediate_2;

    and_gate u1 (intermediate_1, a, b);
    and_gate u2 (intermediate_2, c, d);
    or_gate  u3 (out, intermediate_1, intermediate_2);
    not_gate u4 (out_n, out);

endmodule
module and_gate (
    input a,
    input b,
    output y );

    assign y = a & b;

endmodule
module or_gate (
    input a,
    input b,
    output y );

    assign y = a | b;

endmodule
module not_gate (
    input a,
    output y );

    assign y = !a;

endmodule
