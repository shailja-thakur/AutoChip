module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

wire out_sop_temp1, out_sop_temp2, out_sop_temp3;
assign out_sop_temp1 = ~a & ~b & ~c & ~d;
assign out_sop_temp2 = a & ~b & ~c & ~d;
assign out_sop_temp3 = a & b & ~c & ~d;
assign out_sop = out_sop_temp1 | out_sop_temp2 | out_sop_temp3;

wire out_pos_temp1, out_pos_temp2, out_pos_temp3;
assign out_pos_temp1 = ~a | ~b | ~c | ~d;
assign out_pos_temp2 = ~a | b | ~c | ~d;
assign out_pos_temp3 = ~a | b | c | ~d;
assign out_pos = out_pos_temp1 & out_pos_temp2 & out_pos_temp3;

endmodule
