module top_module(
  input a,
  input b,
  input c,
  output out
);
  
  always @(*) begin
    case({c, b})
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      2'b11: out = 1'b1;
      2'b10: out = 1'b1;
      default: out = 1'bx;
    endcase
  end
endmodule
