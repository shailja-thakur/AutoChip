module top_module(
  input [3:1] y,
  input w,
  output reg Y2
);

  always @(y or w) begin
    case (y)
      3'b000: if (w == 0) Y2 = 0; else Y2 = 1;
      3'b001: if (w == 0) Y2 = 0; else Y2 = 1;
      3'b010: if (w == 0) Y2 = 0; else Y2 = 1;
      3'b011: if (w == 0) Y2 = 1; else Y2 = 0;
      3'b100: if (w == 0) Y2 = 1; else Y2 = 1;
      3'b101: if (w == 0) Y2 = 1; else Y2 = 0;
      default: Y2 = 0;
    endcase
  end

endmodule
