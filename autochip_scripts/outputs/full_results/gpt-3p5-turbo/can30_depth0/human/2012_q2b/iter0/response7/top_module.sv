module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

  reg Y1_reg;
  reg Y3_reg;
  always @(y) begin
    case(y)
      6'b001000: Y1_reg <= y[1];
      6'b010000: Y3_reg <= y[3];
      default:    begin Y1_reg <= 1'b0; Y3_reg <= 1'b0; end
    endcase
  end

  assign Y1 = Y1_reg;
  assign Y3 = Y3_reg;

endmodule
