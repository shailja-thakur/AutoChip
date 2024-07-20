module top_module (
  input a,
  input b,
  input c,
  input d,
  output wire out
);

  assign out = 1'b0;

  always @* begin
    case({c, d, a, b})
      4'b0000: out = 1'b1;
      4'b0001: out = 1'b1;
      4'b0100: out = 1'b0;
      4'b0101: out = d;
      4'b1xxx: out = 1'b1;
      4'b1100: out = 1'b0;
      4'b1110: out = 1'b1;
      4'b1111: out = 1'b1;
    endcase
  end

endmodule
