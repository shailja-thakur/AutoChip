module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire ab_00 = 0;
    wire ab_01 = 1;
    wire ab_10 = 2;
    wire ab_11 = 3;

    wire mux_0_output;
    wire mux_1_output;
    wire mux_2_output;
    wire mux_3_output;

    mux2to1 mux_0 (
        .a(c), 
        .b(d),
        .s(ab_00),
        .y(mux_0_output)
    );

    mux2to1 mux_1 (
        .a(c), 
        .b(d),
        .s(ab_01),
        .y(mux_1_output)
    );

    mux2to1 mux_2 (
        .a(c), 
        .b(d),
        .s(ab_10),
        .y(mux_2_output)
    );

    mux2to1 mux_3 (
        .a(c), 
        .b(d),
        .s(ab_11),
        .y(mux_3_output)
    );

    mux4to1 mux_4 (
        .a(mux_0_output),
        .b(mux_1_output),
        .c(mux_2_output),
        .d(mux_3_output),
        .sel(a),
        .y(mux_in)
    );
    
endmodule
module mux2to1 (
    input a,
    input b,
    input s,
    output y
);
    assign y = (~s & a) | (s & b);
endmodule
module mux4to1 (
    input a,
    input b,
    input c,
    input d,
    input [1:0] sel,
    output y
);
    
    wire mux_0_output;
    wire mux_1_output;

    mux2to1 mux_0 (
        .a(a),
        .b(b),
        .s(sel[0]),
        .y(mux_0_output)
    );

    mux2to1 mux_1 (
        .a(c),
        .b(d),
        .s(sel[0]),
        .y(mux_1_output)
    );

    assign y = (~sel[1] & mux_0_output) | (sel[1] & mux_1_output);
endmodule
