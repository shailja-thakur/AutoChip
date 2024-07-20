module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

  parameter WL = 1'b0;
  parameter WR = 1'b1;

  reg state, next_state;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= WL;
    else
      state <= next_state;
  end

  always @(state or bump_left or bump_right) begin
    case (state)
      WL: begin
        if (bump_left)
          next_state = WR;
        else
          next_state = WL;
      end
      WR: begin
        if (bump_right)
          next_state = WL;
        else
          next_state = WR;
      end
    endcase
  end

  always @(state) begin
    walk_left = (state == WL) ? 1'b1 : 1'b0;
    walk_right = (state == WR) ? 1'b1 : 1'b0;
  end

endmodule
