module top_module(
  input [3:1] y,
  input w,
  output reg Y2
);

  always @* begin
    case({y, w})
      // Transition logic for state A
      3'd0: Y2 = 1'b0;
      3'd1: Y2 = 1'b1;

      // Transition logic for state B
      3'd2: Y2 = 1'b1;
      3'd3: Y2 = 1'b0;

      // Transition logic for state C
      3'd4: Y2 = 1'b1;
      3'd5: Y2 = 1'b0;

      // Transition logic for state D
      3'd6: Y2 = 1'b0;
      3'd7: Y2 = 1'b1;

      // Transition logic for state E
      3'd8: Y2 = 1'b1;
      3'd9: Y2 = 1'b0;

      // Transition logic for state F
      3'd10: Y2 = 1'b1;
      3'd11: Y2 = 1'b0;

      default: Y2 = 1'b0;
    endcase
  end

endmodule
