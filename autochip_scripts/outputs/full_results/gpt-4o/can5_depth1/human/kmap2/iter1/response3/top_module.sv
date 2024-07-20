module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Karnaugh map logic
    assign out = (~a & ~c) | (~b & ~d) | (~c & d) | (a & ~b & c);
    
endmodule
