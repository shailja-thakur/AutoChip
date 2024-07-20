module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // SOP form expressions for the output
    assign out_sop = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & b & ~c & ~d);

    // POS form expressions for the output
    assign out_pos = (~a + ~b + ~c + d) & (~a + ~b + c + ~d) & (~a + b + ~c + ~d);

endmodule
