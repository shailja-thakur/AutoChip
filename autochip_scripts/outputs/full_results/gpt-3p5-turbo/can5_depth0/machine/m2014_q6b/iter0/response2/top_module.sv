module top_module(
  input [3:0] y,
  input w,
  output reg Y2
);
  always_comb begin
    case ({y, w})
      4'd0: Y2 = 1'b0;
      4'd1: Y2 = 1'b0;
      4'd2: Y2 = 1'b1;
      4'd3: Y2 = 1'b1;
      4'd4: Y2 = 1'b0;
      4'd5: Y2 = 1'b1;
      4'd6: Y2 = 1'b0;
      4'd7: Y2 = 1'b0;
      4'd8: Y2 = 1'b0;
      4'd9: Y2 = 1'b1;
      4'dA: Y2 = 1'b1;
      4'dB: Y2 = 1'b1;
      default: Y2 = 1'b0;
    endcase
  end
endmodule
