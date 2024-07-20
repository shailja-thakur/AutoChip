module top_module (
  input a,
  input b,
  input c,
  input d,
  output reg out_sop,
  output reg out_pos
);
  
  always @(a, b, c, d) begin
    out_sop = (c & d) | (~a & ~b & c);
    out_pos = (c & (~b | d | ~a & b)) & (c & (~d | ~a));
  end
  
endmodule
