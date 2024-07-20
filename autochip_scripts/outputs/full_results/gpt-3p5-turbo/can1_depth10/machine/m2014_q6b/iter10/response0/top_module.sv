module top_module(
  input [4:0] y,
  input w,
  output reg Y2
  );

  always_comb begin
    case({y, w})
      5'b0000_0: Y2 = 1'b0;
      5'b0000_1: Y2 = 1'b0;
      5'b0001_0: Y2 = 1'b1;
      5'b0001_1: Y2 = 1'b1;
      5'b0010_0: Y2 = 1'b0;
      5'b0010_1: Y2 = 1'b1;
      5'b0011_0: Y2 = 1'b0;
      5'b0011_1: Y2 = 1'b0;
      5'b0100_0: Y2 = 1'b0;
      5'b0100_1: Y2 = 1'b1;
      5'b0101_0: Y2 = 1'b1;
      5'b0101_1: Y2 = 1'b1;
      default: Y2 = 1'b0;
    endcase
  end

endmodule
