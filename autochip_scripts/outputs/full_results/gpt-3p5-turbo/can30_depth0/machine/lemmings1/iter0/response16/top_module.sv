module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

  parameter WL = 0;
  parameter WR = 1;
  reg state;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= WL;
    else begin
      if (state == WL)
        state <= (bump_left) ? WR : WL;
      else
        state <= (bump_right) ? WL : WR;
    end
  end

  always @(state) begin
    case (state)
      WL: begin
        walk_left <= 1;
        walk_right <= 0;
      end
      WR: begin
        walk_left <= 0;
        walk_right <= 1;
      end
    endcase
  end
endmodule
