module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output reg walk_left,
  output reg walk_right,
  output reg aaah
);

// Enumerated type for the states
typedef enum logic [1:0] {
  WALK_LEFT,
  WALK_RIGHT,
  FALL
} state_type;

// Internal signals
reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= WALK_LEFT;
  end else begin
    state <= next_state;
  end
end

always @(*) begin
  case (state)
    WALK_LEFT: begin
      walk_left = 1;
      walk_right = 0;
      aaah = 0;

      if (bump_right) begin
        next_state = WALK_RIGHT;
      end else if (bump_left && ground) begin
        next_state = WALK_RIGHT;
      end else if (bump_left && !ground) begin
        next_state = FALL;
      end else begin
        next_state = WALK_LEFT;
      end
    end

    WALK_RIGHT: begin
      walk_left = 0;
      walk_right = 1;
      aaah = 0;

      if (bump_left) begin
        next_state = WALK_LEFT;
      end else if (bump_right && ground) begin
        next_state = WALK_LEFT;
      end else if (bump_right && !ground) begin
        next_state = FALL;
      end else begin
        next_state = WALK_RIGHT;
      end
    end

    FALL: begin
      walk_left = state == WALK_LEFT;
      walk_right = state == WALK_RIGHT;
      aaah = 1;

      if (ground) begin
        next_state = state;
      end else if (bump_left || bump_right) begin
        next_state = FALL;
      end else begin
        if (state == WALK_LEFT) begin
          next_state = WALK_LEFT;
        end else begin
          next_state = WALK_RIGHT;
        end
      end
    end
  endcase
end

endmodule
