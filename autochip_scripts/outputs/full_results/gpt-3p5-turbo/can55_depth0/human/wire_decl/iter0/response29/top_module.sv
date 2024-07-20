module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire intermediate1;
    wire intermediate2;
    
    and and1 (intermediate1, a, b);
    and and2 (intermediate2, c, d);
    or or1 (out, intermediate1, intermediate2);
    not not1 (out_n, out);

endmodule
module and (
    output and_out,
    input and_in1,
    input and_in2 );

    assign and_out = and_in1 & and_in2;

endmodule
module or (
    output or_out,
    input or_in1,
    input or_in2 );

    assign or_out = or_in1 | or_in2;

endmodule
module not (
    output not_out,
    input not_in );

    assign not_out = ~not_in;

endmodule
