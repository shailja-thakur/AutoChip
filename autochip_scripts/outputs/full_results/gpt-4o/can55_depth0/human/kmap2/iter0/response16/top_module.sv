module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    // Simplifying the Karnaugh map, we get the following expression:
    // F(a, b, c, d) = a'b'c'd' + a'b'c'd + a'b'cd' + a'b'cd + a'bcd' + ab'c'd' + ab'c'd + ab'cd + ab'c'd' + abc'd + abc'd
    //  = a'b'c' + a'b'd + a'cd + a'cd' + ab'd + ab'cd'
    assign out = (~a & ~c) | (~a & ~d) | (~b & d) | (a & b & ~d);

endmodule
