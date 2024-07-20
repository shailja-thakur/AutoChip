module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
  
  wire sop_c_d;
  wire sop_not_a_not_b_c;
  wire pos0;
  wire pos1;
  
  // Generate out_sop
  assign sop_c_d = c & d;
  assign sop_not_a_not_b_c = (~a) & (~b) & c;
  assign out_sop = sop_c_d | sop_not_a_not_b_c;
  
  // Generate out_pos
  assign pos0 = c & ((~b) | d) & (~a | b);
  assign pos1 = c & (~a | d);
  
  assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
  
endmodule
