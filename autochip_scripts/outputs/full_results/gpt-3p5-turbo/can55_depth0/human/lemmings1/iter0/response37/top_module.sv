module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
  
  // Define the state enumeration
  typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT
  } STATE;
  
  // Define the state variable
  STATE current_state, next_state;
  
  // Define the output variable
  logic walk_left, walk_right;
  
  // Flip-Flop for synchronizing the reset signal
  always @(posedge clk or posedge areset) begin
    if (areset)
      current_state <= WALK_LEFT;
    else
      current_state <= next_state;
  end
  
  // Combinational logic for determining the next state and output
  always @(*) begin
    case (current_state)
      WALK_LEFT: begin
        if (bump_left == 1 || (bump_left == 1 && bump_right == 1))
          next_state = WALK_RIGHT;
        else
          next_state = WALK_LEFT;
          
        walk_left = 1;
        walk_right = 0;
      end
      
      WALK_RIGHT: begin
        if (bump_right == 1 || (bump_left == 1 && bump_right == 1))
          next_state = WALK_LEFT;
        else
          next_state = WALK_RIGHT;
          
        walk_left = 0;
        walk_right = 1;
      end
    endcase
  end
  
endmodule
