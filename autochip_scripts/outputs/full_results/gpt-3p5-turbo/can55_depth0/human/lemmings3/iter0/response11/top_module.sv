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
  typedef enum logic[1:0] {
    IDLE,
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
  } state_t;
  
  // Define the state and next state variables
  state_t state, next_state;
  
  // Define the combinational outputs
  always_comb begin
    case (state)
      IDLE:
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      WALK_LEFT:
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      WALK_RIGHT:
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
        digging = 0;
      FALL:
        walk_left = walk_left;
        walk_right = walk_right;
        aaah = (ground == 0);
        digging = 0;
      DIG:
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 1;
    endcase
  end
  
  // Define the sequential logic
  always_ff @(posedge clk or posedge areset) begin
    if (areset == 1'b1) begin
      state <= WALK_LEFT;
    end else begin
      state <= next_state;
    end
  end
  
  // Define the next state logic
  always_comb begin
    next_state = state;
    case (state)
      IDLE:
        if (bump_left == 1'b1) begin
          next_state = WALK_RIGHT;
        end else if (bump_right == 1'b1) begin
          next_state = WALK_LEFT;
        end else if (dig == 1'b1 && ground == 1'b1) begin
          next_state = DIG;
        end
      WALK_LEFT:
        if (bump_left == 1'b1) begin
          next_state = WALK_RIGHT;
        end else if (dig == 1'b1 && ground == 1'b1) begin
          next_state = DIG;
        end else if (ground == 0) begin
          next_state = FALL;
        end
      WALK_RIGHT:
        if (bump_right == 1'b1) begin
          next_state = WALK_LEFT;
        end else if (dig == 1'b1 && ground == 1'b1) begin
          next_state = DIG;
        end else if (ground == 0) begin
          next_state = FALL;
        end
      FALL:
        if (ground == 1'b1) begin
          next_state = (walk_left == 1'b1) ? WALK_LEFT : WALK_RIGHT;
        end
      DIG:
        if (ground == 0) begin
          next_state = FALL;
        end
    endcase
  end
  
endmodule
