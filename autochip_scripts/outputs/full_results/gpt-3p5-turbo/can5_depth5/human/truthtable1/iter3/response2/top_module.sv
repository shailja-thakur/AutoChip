module top_module (
  input x3,
  input x2,
  input x1,
  output reg f
);

  always @(*) begin
    case ({x3, x2, x1})
      3'b100, 3'b010, 3'b001, 3'b111: f = 1;
      default: f = 0;
    endcase
  end

endmodule
