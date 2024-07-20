module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

// SOP expression
wire sop_expr_1 = c & d;
wire sop_expr_2 = (~a & ~b) & c;
wire out_sop = sop_expr_1 | sop_expr_2;

// POS expression
wire pos_expr_1 = c & (~b | d) & (~a | b);
wire pos_expr_2 = c & (~a | d);
wire pos0 = pos_expr_1;
wire pos1 = pos_expr_2;
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
