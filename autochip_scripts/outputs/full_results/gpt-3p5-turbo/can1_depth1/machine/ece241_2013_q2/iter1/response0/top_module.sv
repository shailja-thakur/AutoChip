module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    reg pos0, pos1;

    always @(*) begin
        out_sop = (c & d) | ((!a & !b) & c);
        pos0 = c & (!b | d) | (!a & b);
        pos1 = c & (!a | d);
        out_pos = (pos0 == pos1) ? pos0 : 1'bx;
    end

endmodule
