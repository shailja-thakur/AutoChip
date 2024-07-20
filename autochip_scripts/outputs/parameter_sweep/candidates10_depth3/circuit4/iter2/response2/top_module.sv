module top_module (
  input a,
  input b,
  input c,
  input d,
  output reg q
);

  always @* begin
    if ((a & b) | (c & ~d))
      q <= 1'b1;
    else
      q <= 1'b0;
  end
  
endmodule
