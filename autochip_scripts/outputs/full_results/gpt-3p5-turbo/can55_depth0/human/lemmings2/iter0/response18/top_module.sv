module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

reg [1:0] state;
parameter IDLE = 2'b00;
parameter WALK_LEFT = 2'b01;
parameter WALK_RIGHT = 2'b10;

always @(posedge clk, posedge areset)
begin
  if (areset)
    state <= IDLE;
  else
  begin
    case (state)
      IDLE:
        if (bump_left && !bump_right)
          state <= WALK_RIGHT;
        else if (bump_right && !bump_left)
          state <= WALK_LEFT;
        else if (bump_left && bump_right)
          state <= WALK_RIGHT;
        else if (!ground)
          state <= IDLE;
      WALK_LEFT:
        if (bump_right && !bump_left)
          state <= WALK_RIGHT;
        else if (!ground)
          state <= IDLE;
      WALK_RIGHT:
        if (bump_left && !bump_right)
          state <= WALK_LEFT;
        else if (!ground)
          state <= IDLE;
      default:
        state <= IDLE;
    endcase
  end
end

always @(*)
begin
  case (state)
    IDLE:
      begin
        walk_left = 1'b1;
        walk_right = 1'b0;
        aaah = 1'b0;
      end
    WALK_LEFT:
      begin
        walk_left = 1'b1;
        walk_right = 1'b0;
        aaah = 1'b0;
      end
    WALK_RIGHT:
      begin
        walk_left = 1'b0;
        walk_right = 1'b1;
        aaah = 1'b0;
      end
    default:
      begin
        walk_left = 1'b1;
        walk_right = 1'b0;
        aaah = 1'b1;
      end
  endcase
end

endmodule
