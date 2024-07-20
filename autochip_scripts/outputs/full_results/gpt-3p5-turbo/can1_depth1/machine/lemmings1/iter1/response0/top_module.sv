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
reg next_state;

always @(posedge clk or posedge areset) begin
  if (areset)
    state <= WL;
  else
    state <= next_state;
end

always @(*) begin
  if (state == WL)
    next_state = (bump_left) ? WR : WL;
  else if (state == WR)
    next_state = (bump_right) ? WL : WR;
end

always @(posedge clk) begin
  if (areset)
    walk_left <= 1;
  else if (state == WL)
    walk_left <= 1;
  else if (state == WR)
    walk_left <= 0;
end

always @(posedge clk) begin
  if (areset)
    walk_right <= 0;
  else if (state == WL)
    walk_right <= 0;
  else if (state == WR)
    walk_right <= 1;
end

endmodule
