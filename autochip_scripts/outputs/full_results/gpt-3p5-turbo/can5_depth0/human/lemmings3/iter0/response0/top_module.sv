module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output walk_left,
  output walk_right,
  output aaah,
  output digging
);

  // State Enumeration
  typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
  } state_type;

  // Registers
  reg [2:0] state, next_state;

  // Outputs
  assign walk_left = (state == WALK_LEFT);
  assign walk_right = (state == WALK_RIGHT);
  assign aaah = (state == FALL);
  assign digging = (state == DIG);

  // State Transition and Output Logic
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
    end else begin
      state <= next_state;
    end
  end

  // Next State and Output Logic
  always_comb begin
    next_state = state;
    aaah = 0;

    case (state)
      WALK_LEFT:
        if (bump_right) begin
          next_state = WALK_RIGHT;
        end else if (!ground) begin
          next_state = FALL;
        end else if (dig) begin
          next_state = DIG;
        end
      WALK_RIGHT:
        if (bump_left) begin
          next_state = WALK_LEFT;
        end else if (!ground) begin
          next_state = FALL;
        end else if (dig) begin
          next_state = DIG;
        end
      FALL:
        if (ground && !dig) begin
          next_state = state;
        end else if (walk_left) begin
          next_state = WALK_LEFT;
        end else if (walk_right) begin
          next_state = WALK_RIGHT;
        end
      DIG:
        if (!ground) begin
          next_state = FALL;
        end
    endcase
  end

endmodule
