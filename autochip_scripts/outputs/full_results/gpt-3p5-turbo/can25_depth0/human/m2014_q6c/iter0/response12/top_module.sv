module top_module (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

  reg Y2_reg, Y4_reg;

  always @* begin
    case(y)
      7'b000001 : begin
        Y2_reg <= y[2];
        Y4_reg <= y[4];
      end
      7'b000010 : begin
        Y2_reg <= y[2];
        Y4_reg <= y[4];
      end
      7'b000100 : begin
        Y2_reg <= y[2];
        Y4_reg <= y[4];
      end
      7'b001000 : begin
        Y2_reg <= y[2];
        Y4_reg <= y[4];
      end
      7'b010000 : begin
        Y2_reg <= y[2];
        Y4_reg <= y[4];
      end
      7'b100000 : begin
        Y2_reg <= y[2];
        Y4_reg <= y[4];
      end
    endcase
  end

  assign Y2 = Y2_reg;
  assign Y4 = Y4_reg;

endmodule
