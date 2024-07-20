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

  // Define the state enumeration
  typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
  } state_t;

  // Declare the current state variable
  reg state_t current_state;

  // Declare the next state variable
  reg state_t next_state;

  // Declare the output variables
  reg walk_left;
  reg walk_right;
  reg aaah;
  reg digging;

  // Define the state transition logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset the state machine
      current_state <= WALK_LEFT;
    end else begin
      // Update the current state based on the next state
      current_state <= next_state;
    end
  end

  // Define the state logic
  always @* begin
    case (current_state)
      WALK_LEFT:
        begin
          walk_left = 1;
          walk_right = 0;
          aaah = 0;
          digging = 0;
          if (bump_right)
            next_state = WALK_RIGHT;
          else if (ground == 0)
            next_state = FALL;
          else if (dig)
            next_state = DIG;
          else
            next_state = WALK_LEFT;
        end
      WALK_RIGHT:
        begin
          walk_left = 0;
          walk_right = 1;
          aaah = 0;
          digging = 0;
          if (bump_left)
            next_state = WALK_LEFT;
          else if (ground == 0)
            next_state = FALL;
          else if (dig)
            next_state = DIG;
          else
            next_state = WALK_RIGHT;
        end
      FALL:
        begin
          walk_left = walk_left;
          walk_right = walk_right;
          aaah = 1;
          digging = 0;
          if (ground == 1)
            next_state = current_state;
          else
            next_state = FALL;
        end
      DIG:
        begin
          walk_left = walk_left;
          walk_right = walk_right;
          aaah = 0;
          if (ground == 1)
            next_state = current_state;
          else if (ground == 0)
            next_state = FALL;
        end
    endcase
  end

endmodule
