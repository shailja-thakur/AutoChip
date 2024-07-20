module top_module(
  input x,
  input y,
  output z);

  reg z_next;
  always @(x, y)
    begin
      case({x, y})
        2'b00, 2'b01, 2'b10: z_next = 0; // x=0 or y=0
        2'b11: z_next = 1; // x=1 and y=1
      endcase
    end

  always @(posedge clk)
    if (reset)
      z <= 0;
    else
      z <= z_next;

endmodule
