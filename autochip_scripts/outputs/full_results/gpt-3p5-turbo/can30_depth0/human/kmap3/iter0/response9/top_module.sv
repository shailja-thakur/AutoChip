module top_module (
  input a, 
  input b,
  input c,
  input d,
  output reg out
);

  always @ (a or b or c or d) begin
    case ({c, d, a, b})
      4'b00xx: out = 1'b1;
      4'b01xx: out = 1'b0;
      4'b10xx: out = 1'b1;
      4'b11xx: out = 1'b1;
      default: out = 1'b0;
    endcase
  end

endmodule
