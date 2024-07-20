module top_module(
    input a, 
    input b,
    input c,
    output out
);
    assign out = ~a & ~b & c | ~a & b | a & c | a & b;
endmodule
