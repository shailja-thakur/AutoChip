module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    // Karnaugh map simplification expression:
    // out = !a&!b&!c | !a&!b&!d | !a&b&!d | !a&c&!d | a&!b&c&d | a&b&!c&d | a&b&c&!d | a&b&c&d

    assign out = (!a & !b & !c) | (!a & !b & !d) | (!a & b & !d) | (!a & c & !d) | (a & !b & c & d) | (a & b & !c & d) | (a & b & c & !d) | (a & b & c & d);

endmodule
