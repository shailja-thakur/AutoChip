module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);
    
    wire m0, m1, m2, m3, m4, m5, m6, m7;
    
    assign m0 = ~a & ~b & ~c & d;
    assign m1 = ~a & ~b & c & d;
    assign m2 = a & ~b & c & d;
    assign m3 = a & ~b & ~c & d;
    assign m4 = a & b & c & d;
    assign m5 = a & b & ~c & d;
    assign m6 = ~a & b & ~c & d;
    assign m7 = ~a & b & c & d;
    
    assign out = m0 | m1 | m2 | m3 | m4 | m5 | m6 | m7;
    
endmodule
