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

  // Define the states of the finite state machine
  typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG,
    FALL_AND_CONTINUE_WALK
  } state_t;

  // Define the signals used in the state machine
  reg [2:0] current_state;
  reg [2:0] next_state;
  reg walk_left;
  reg walk_right;
  reg aaah;
  reg digging;

  // Asynchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
    end else begin
      current_state <= next_state;
    end
  end

  // Transition and output logic
  always @(*) begin
    case (current_state)

      WALK_LEFT: begin
        if (bump_right) begin
          next_state = WALK_RIGHT;
        end else if (!ground) begin
          next_state = FALL;
        end else if (dig) begin
          next_state = DIG;
        end else begin
          next_state = WALK_LEFT;
        end
      end

      WALK_RIGHT: begin
        if (bump_left) begin
          next_state = WALK_LEFT;
        end else if (!ground) begin
          next_state = FALL;
        end else if (dig) begin
          next_state = DIG;
        end else begin
          next_state = WALK_RIGHT;
        end
      end

      FALL: begin
        if (ground) begin
          next_state = FALL_AND_CONTINUE_WALK;
        end else begin
          next_state = FALL;
        end
      end

      DIG: begin
        if (!ground || current_state == FALL || current_state == FALL_AND_CONTINUE_WALK) begin
          next_state = current_state;
        end else if (!ground && current_state == DIG) begin
          next_state = FALL;
        end else begin
          next_state = DIG;
        end
      end

      FALL_AND_CONTINUE_WALK: begin
        if (bump_left) begin
          next_state = WALK_LEFT;
        end else if (bump_right) begin
          next_state = WALK_RIGHT;
        end else if (!ground) begin
          next_state = FALL;
        end else if (dig) begin
          next_state = DIG;
        end else begin
          next_state = FALL_AND_CONTINUE_WALK;
        end
      end

      default: next_state = WALK_LEFT;
    endcase
  end

  // Output assignments based on the current state
  always @(posedge clk) begin
    case (current_state)
      WALK_LEFT: begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end

      WALK_RIGHT: begin
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
        digging = 0;
      end

      FALL: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
        digging = 0;
      end

      DIG: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 1;
      end

      FALL_AND_CONTINUE_WALK: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
        digging = 0;
      end

      default: begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end
    endcase
  end

endmodule
