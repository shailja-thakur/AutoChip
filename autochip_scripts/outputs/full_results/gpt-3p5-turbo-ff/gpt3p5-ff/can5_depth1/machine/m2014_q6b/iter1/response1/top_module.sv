module top_module(
  input [3:0] y,
  input w,
  output reg Y2);

  always_comb begin
    case(y)
      4'b0000, 4'b0001: Y2 = 1'b0;
      4'b0010, 4'b0011, 4'b1001, 4'b1010, 4'b1011: Y2 = 1'b1;
      4'b0101: Y2 = 1'b1;
      default: Y2 = 1'b0;
    endcase
  end

endmodule
