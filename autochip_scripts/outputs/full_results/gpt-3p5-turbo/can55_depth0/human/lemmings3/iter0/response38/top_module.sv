module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output reg walk_left,
  output reg walk_right,
  output reg aaah,
  output reg digging
);

reg [1:0] state;
parameter LEFT = 2'b00;
parameter RIGHT = 2'b01;
parameter DIGGING = 2'b10;

always @(posedge clk or posedge areset) begin
  if (areset)
    state <= LEFT;
  else begin
    case (state)
      LEFT:
        if (bump_left)
          state <= RIGHT;
        else if (ground)
          state <= LEFT;
        else
          state <= DIGGING;
      RIGHT:
        if (bump_right)
          state <= LEFT;
        else if (ground)
          state <= RIGHT;
        else
          state <= DIGGING;
      DIGGING:
        if (ground)
          state <= state;
        else
          state <= LEFT;
    endcase
  end
end

always @(state, ground, dig) begin
  case (state)
    LEFT:
      begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end
    RIGHT:
      begin
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
        digging = 0;
      end
    DIGGING:
      begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 1;
      end
  endcase
end

endmodule
