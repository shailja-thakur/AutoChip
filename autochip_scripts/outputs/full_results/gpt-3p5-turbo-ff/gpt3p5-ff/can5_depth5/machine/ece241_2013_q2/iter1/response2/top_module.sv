module top_module (
  input a,
  input b,
  input c,
  input d,
  output reg out_sop,
  output reg [1:0] out_pos
);

  wire pos0, pos1;

  always @(*) begin
    out_sop = (c & d) | ((!a & !b) & c);
    pos0 = c & ((!b & d) | (!a & b));
    pos1 = c & (!a & d);

    if(pos0 == pos1)
      out_pos = pos0;
    else
      out_pos = 2'b?; // Use 2'b? instead of 1'bx
  end

endmodule
