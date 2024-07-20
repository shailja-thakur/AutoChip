module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    assign out = ( ~c & ~d ) | ( ~a & ~d ) | ( ~a & b & d ) | ( a & b & ~d ) | ( a & ~b & d );
endmodule
