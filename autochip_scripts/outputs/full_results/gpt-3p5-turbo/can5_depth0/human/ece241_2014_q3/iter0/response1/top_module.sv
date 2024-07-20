module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire ab0, ab1, ab2, ab3;
    wire mux_out0, mux_out1, mux_out2, mux_out3;

    and gate0 (.a(c), .b(d), .z(ab0));
    and gate1 (.a(c), .b(~d), .z(ab1));
    and gate2 (.a(~c), .b(~d), .z(ab2));
    and gate3 (.a(~c), .b(d), .z(ab3));

    mux2to1 mux0 (.a(ab0), .b(ab1), .s(a), .z(mux_out0));
    mux2to1 mux1 (.a(ab2), .b(ab3), .s(a), .z(mux_out1));
    mux2to1 mux2 (.a(mux_out0), .b(mux_out1), .s(b), .z(mux_out2));

    assign mux_in[0] = mux_out2;
    assign mux_in[1] = ab1;
    assign mux_in[2] = ab2;
    assign mux_in[3] = mux_out1;

endmodule
module mux2to1 (
    input a,
    input b,
    input s,
    output z
);

    assign z = (s == 0) ? a : b;
    
endmodule
module and (
    input a,
    input b,
    output z
);

    assign z = a & b;
    
endmodule
