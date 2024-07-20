module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    assign q = 
    (~a & ~b & ~c & d) | // case 0
    (~a & ~b & c & ~d) | // case 1
    (~a & b & ~c & d) |  // case 2
    (~a & b & c & d)  |  // case 3
    (a & ~b & ~c & ~d) | // case 4
    (a & ~b & c & d)  |  // case 5
    (a & b & ~c & d)  |  // case 6
    (a & b & c & d);       // case 7
endmodule
