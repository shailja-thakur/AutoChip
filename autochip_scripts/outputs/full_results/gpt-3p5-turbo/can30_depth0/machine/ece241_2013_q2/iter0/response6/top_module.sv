module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  wire sop_a_not;
  wire sop_b_not;
  wire sop_c_and_d;
  wire sop_a_not_b_not_c_and;
  wire sop_pos_0;
  wire sop_pos_1;
  
  // SOP expression
  assign sop_a_not = ~a;
  assign sop_b_not = ~b;
  assign sop_c_and_d = c & d;
  assign sop_a_not_b_not_c_and = sop_a_not & sop_b_not & c;
  assign out_sop = sop_c_and_d | sop_a_not_b_not_c_and;
  
  // POS expression
  assign sop_pos_0 = c & (sop_b_not | d) & (sop_a_not | b);
  assign sop_pos_1 = c & (sop_b_not | d) & (sop_a_not | d);
  assign out_pos = (sop_pos_0 === sop_pos_1) ? sop_pos_0 : 1'bx;
  
endmodule
