module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    /* Declaration of intermediate signals */
    wire y1, y2, y3, y4, y5, y6, y7, y8;

    /* Generate combinational logic for SOP form */
    assign y1 = ~(a | b | c | d); // 2
    assign y2 = ~(a & b & c & ~d); // 7
    assign y3 = ~(~a & ~b & ~c & d); // 15
    
    /* Generate out_sop */
    assign out_sop = y1 | y2 | y3;

    /* Generate combinational logic for POS form */
    assign y4 = (a & b & c & ~d); // 0
    assign y5 = (a | b | c | d); // 1
    assign y6 = (a & b & ~c & d); // 4
    assign y7 = (a | ~b | c | d); // 5
    assign y8 = (a & ~b & ~c & d); // 6
    wire y9 = (a | b | ~c | d); // 9
    wire y10 = (~a | b | c | d); // 10
    wire y11 = (a | ~b | ~c | d); // 13
    wire y12 = (a | b | c | ~d); // 14
    
    /* Generate out_pos */
    assign out_pos = ~(y4 & y5 & y6 & y7 & y8 & y9 & y10 & y11 & y12);

endmodule
