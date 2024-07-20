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
    wire y9, y10, y11, y12, y13, y14, y15, y16;

    /* Generate combinational logic for SOP form */
    assign y1 = ~a & ~b & ~c & ~d;
    assign y2 = ~a & ~b & ~c & d;
    assign y3 = ~a & ~b & c & ~d;
    assign y4 = ~a & ~b & c & d;
    assign y5 = ~a & b & ~c & ~d;
    assign y6 = ~a & b & ~c & d;
    assign y7 = ~a & b & c & ~d;
    assign y8 = ~a & b & c & d;
    
    /* Generate out_sop */
    assign out_sop = y2 | y7 | y8;

    /* Generate combinational logic for POS form */
    assign y9 = a | b | c | d;
    assign y10 = a | b | c | ~d;
    assign y11 = a | b | ~c | d;
    assign y12 = a | b | ~c | ~d;
    assign y13 = a | ~b | c | d;
    assign y14 = a | ~b | c | ~d;
    assign y15 = a | ~b | ~c | d;
    assign y16 = a | ~b | ~c | ~d;
    
    assign out_pos = y9 & y10 & y11 & y12 & y13 & y14 & y15 & y16;

endmodule
