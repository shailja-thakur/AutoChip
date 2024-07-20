module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire intermediate1;
    wire intermediate2;
    
    and gate1(intermediate1, a, b);
    and gate2(intermediate2, c, d);
    or gate3(out, intermediate1, intermediate2);
    not invert_out(out_n, out);

endmodule
module and (
    output out,
    input a,
    input b
);
    assign out = a & b;
endmodule
module or (
    output out,
    input a,
    input b
);
    assign out = a | b;
endmodule
module not (
    output out,
    input a
);
    assign out = ~a;
endmodule
