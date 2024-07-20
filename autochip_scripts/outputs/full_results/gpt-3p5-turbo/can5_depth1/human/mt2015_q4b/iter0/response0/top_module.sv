module top_module(
  input x,
  input y,
  output z);

  reg z;

  always @(x or y)
    case({x, y})
      2'b00, 2'b01, 2'b10: z = 1;
      default: z = 0;
    endcase

endmodule
