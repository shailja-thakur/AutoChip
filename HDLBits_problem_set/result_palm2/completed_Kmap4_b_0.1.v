module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    // Insert your code here

    NOT(out, a);
    AND(out, b, c, d);

endmodule