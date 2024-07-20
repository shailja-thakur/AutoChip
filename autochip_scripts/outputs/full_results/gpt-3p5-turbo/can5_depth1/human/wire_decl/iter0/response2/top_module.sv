module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire and1_output;
    wire and2_output;

    and gate1 (and1_output, a, b);
    and gate2 (and2_output, c, d);
    or gate3 (out, and1_output, and2_output);
    not gate4 (out_n, out);
    
endmodule
module and (
    output and_output,
    input input1,
    input input2 );

    assign and_output = input1 & input2;

endmodule
module or (
    output or_output,
    input input1,
    input input2 );

    assign or_output = input1 | input2;

endmodule
module not (
    output not_output,
    input input );

    assign not_output = ~input;

endmodule
