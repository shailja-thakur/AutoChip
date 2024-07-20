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
parameter [1:0]
  WALK_LEFT = 'h0,
  WALK_RIGHT = 'h1,
  DIG_FALL = 'h2;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= WALK_LEFT;
    walk_left <= 1;
    walk_right <= 0;
    aaah <= 0;
    digging <= 0;
  end else begin
    case (state)
      WALK_LEFT:
        if (bump_right && ground) begin
          state <= WALK_RIGHT;
          walk_left <= 0;
          walk_right <= 1;
          aaah <= 0;
          digging <= 0;
        end else if (!ground) begin
          state <= DIG_FALL;
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 1;
          digging <= 0;
        end
      WALK_RIGHT:
        if (bump_left && ground) begin
          state <= WALK_LEFT;
          walk_left <= 1;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
        end else if (!ground) begin
          state <= DIG_FALL;
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 1;
          digging <= 0;
        end
      DIG_FALL:
        if (ground) begin
          state <= WALK_LEFT;
          walk_left <= 1;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
        end
      default:
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    endcase
  end
end

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= WALK_LEFT;
    walk_left <= 1;
    walk_right <= 0;
    aaah <= 0;
    digging <= 0;
  end else begin
    case (state)
      WALK_LEFT:
        if (bump_right && ground) begin
          state <= WALK_RIGHT;
          walk_left <= 0;
          walk_right <= 1;
          aaah <= 0;
          digging <= 0;
        end else if (!ground && !dig) begin
          state <= DIG_FALL;
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 1;
          digging <= 0;
        end
      WALK_RIGHT:
        if (bump_left && ground) begin
          state <= WALK_LEFT;
          walk_left <= 1;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
        end else if (!ground && !dig) begin
          state <= DIG_FALL;
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 1;
          digging <= 0;
        end
      DIG_FALL:
        if (ground) begin
          state <= WALK_LEFT;
          walk_left <= 1;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
        end else if (dig) begin
          state <= DIG_FALL;
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 0;
          digging <= 1;
        end
      default:
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    endcase
  end
end

endmodule
