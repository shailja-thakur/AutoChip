module top_module (
  input a, 
  input b,
  input c,
  input d,
  output reg out
);

always @(*) begin
  case({c, d, a, b})
    4'b00x0: out = 1;
    4'b0100: out = 1;
    4'b0101: out = d;
    4'b0110: out = d;
    4'b0111: out = d;
    4'b1110: out = 1;
    4'b1111: out = 1;
    default: out = 0;
  endcase
end

endmodule
