module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

  reg [1:0] state;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00;
    else if (state == 2'b00)
      state <= (bump_left) ? 2'b01 : 2'b00;
    else if (state == 2'b01)
      state <= (bump_right) ? 2'b00 : 2'b01;
  end

  assign walk_left = (state == 2'b00);
  assign walk_right = (state == 2'b01);

endmodule
