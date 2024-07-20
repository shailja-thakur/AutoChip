module top_module(
  input [3:1] y,
  input w,
  output reg Y2
);

  always @(*) begin
    case(y)
      3'b000, 3'b001: Y2 = 0; // States A and B
      3'b010, 3'b011, 3'b100, 3'b101: Y2 = y[1]; // States C, D, E, and F
      default: Y2 = 0; // Default case
    endcase
  end

endmodule
