module top_module (
  input a,
  input b,
  input c,
  input d,
  output reg out_sop,
  output reg out_pos
);

  wire sop0;  // intermediate wire for out_sop calculation
  wire pos0;  // intermediate wire for out_pos calculation
  wire pos1;  // intermediate wire for out_pos calculation

  // Assignments for out_sop calculation
  assign sop0 = (c & d) | ((~a & ~b) & c);
  always @(*) begin
    out_sop = sop0;
  end

  // Assignments for out_pos calculation
  assign pos0 = c & (~b | d) | (~a & b);
  assign pos1 = c & (~a | d);
  always @(*) begin
    out_pos = (pos0 === pos1) ? pos0 : 1'bx;
  end
endmodule
