module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire i2, i7, i15, i0, i1, i4, i5, i6, i9, i10, i13, i14;

    assign i2 = (a & !b & c & d);
    assign i7 = (!a & b & c & d);
    assign i15 = (a & b & c & d);

    assign i0 = (!a & !b & !c & !d);
    assign i1 = (!a & !b & !c & d);
    assign i4 = (!a & b & !c & !d);
    assign i5 = (!a & b & !c & d);
    assign i6 = (!a & b & c & !d);
    assign i9 = (a & b & !c & !d);
    assign i10 = (a & b & !c & d);
    assign i13 = (a & b & c & !d);
    assign i14 = (a & b & c & d);

    assign out_sop = i2 | i7 | i15;
    assign out_pos = i0 | i1 | i4 | i5 | i6 | i9 | i10 | i13 | i14;

endmodule
