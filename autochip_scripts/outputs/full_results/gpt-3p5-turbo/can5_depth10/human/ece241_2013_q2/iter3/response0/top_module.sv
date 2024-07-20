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
    assign y1 = (~a & ~b & ~c & ~d);
    assign y2 = (~a & ~b & ~c & d);
    assign y3 = (~a & ~b & c & ~d);
    assign y4 = (~a & ~b & c & d);
    assign y5 = (~a & b & ~c & ~d);
    assign y6 = (~a & b & ~c & d);
    assign y7 = (a & ~b & c & ~d);
    assign y8 = (a & b & c & d);
    
    /* Generate out_sop */
    assign out_sop = y2 | y7 | y8;

    /* Generate combinational logic for POS form */
    assign out_pos = (~a & ~b & ~c & ~d) | (~a & b & c & d) | (a & ~b & c & ~d);

endmodule
