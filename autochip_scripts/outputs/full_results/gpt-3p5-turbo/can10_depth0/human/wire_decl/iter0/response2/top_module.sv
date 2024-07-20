module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire intermediate1;
    wire intermediate2;

    and gate1 (intermediate1, a, b);
    and gate2 (intermediate2, c, d);
    or gate3 (out, intermediate1, intermediate2);
    not gate4 (out_n, out);
 
endmodule
module and (
    output out,
    input in1,
    input in2 );

    assign out = in1 & in2;
  
endmodule
module or (
    output out,
    input in1,
    input in2 );

    assign out = in1 | in2;
  
endmodule
module not (
    output out,
    input in );

    assign out = ~in;
  
endmodule
