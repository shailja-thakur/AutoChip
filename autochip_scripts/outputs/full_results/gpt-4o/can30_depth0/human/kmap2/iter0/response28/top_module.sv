module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = ( ~c & ~d ) | ( ~a & ~b ) | ( b & d ) | ( a & ~b & c );

endmodule
