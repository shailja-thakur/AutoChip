module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

  always @(*) begin
    if ((~a & ~b & ~c & d) || (~a & ~b & c & ~d) || (~a & b & ~c & ~d) || (b & ~c & d) || (b & c & ~d) || (b & c & d))
      q = 1;
    else
      q = 0;
  end

endmodule
