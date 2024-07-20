module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    wire ab00 = ~a & ~b;
    wire ab01 = ~a &  b;
    wire ab10 =  a  & ~b;
    wire ab11 =  a  &  b;

    wire m0;
    wire m1;
    wire m2;
    wire m3;
    wire m4;
    wire m5;
    wire m6;
    wire m7;

    assign mux_in[0] = m7;
    assign mux_in[1] = m5;
    assign mux_in[2] = m0;
    assign mux_in[3] = m1;

    mux_2to1 M0(
        .a(m1),
        .b(m0),
        .s(c),
        .y(m7)
    );

    mux_4to1 M1(
        .a(m3),
        .b(m2),
        .c(m6),
        .d(m5),
        .s(d),
        .y(m1)
    );

    mux_2to1 M2(
        .a(micro2),
        .b(ab01),
        .s(c),
        .y(m5)
    );

    mux_2to1 M3(
        .a(ab00),
        .b(micro1),
        .s(d),
        .y(m0)
    );

    mux_2to1 M4(
        .a(~a),
        .b(~b),
        .s(c),
        .y(m2)
    );

    mux_2to1 M5(
        .a(c),
        .b(ab10),
        .s(d),
        .y(m3)
    );

    mux_2to1 M6(
        .a(ab11),
        .b(b),
        .s(c),
        .y(m6)
    );

    mux_2to1 M7(
        .a(ab00),
        .b(ab10),
        .s(d),
        .y(micro1)
    );

    mux_2to1 M8(
        .a(ab01),
        .b(ab11),
        .s(d),
        .y(micro2)
    );
endmodule
module mux_2to1 (
	input a,
	input b,
	input s,
	output y
);
    assign y = (s == 0) ? a : b;
endmodule
module mux_4to1 (
	input a,
	input b,
	input c,
	input d,
	input s,
	output y
);
    wire m0;
    wire m1;
    wire m2;
    wire m3;

    mux_2to1 M0(
        .a(a),
        .b(b),
        .s(s[0]),
        .y(m0)
    );

    mux_2to1 M1(
        .a(c),
        .b(d),
        .s(s[0]),
        .y(m1)
    );

    mux_2to1 M2(
        .a(m0),
        .b(m1),
        .s(s[1]),
        .y(m2)
    );

    mux_2to1 M3(
        .a(a),
        .b(b),
        .s(s[0]),
        .y(m3)
    );

    mux_2to1 M4(
        .a(c),
        .b(d),
        .s(s[0]),
        .y(y)
    );
endmodule
