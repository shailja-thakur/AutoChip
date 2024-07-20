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
  
  parameter WALK_LEFT = 1'b1;
  parameter WALK_RIGHT = 1'b1;
  
  reg [4:0] state;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 0;
    else begin
      case (state)
        0: begin // Initial state
          walk_left <= WALK_LEFT;
          walk_right <= ~WALK_LEFT;
          aaah <= 0;
          digging <= 0;
          
          if (ground == 0) // Lemming falls
            state <= 1;
          else if (bump_left == 1 && bump_right == 0) // Lemming bumped on the left
            state <= 2;
          else if (bump_left == 0 && bump_right == 1) // Lemming bumped on the right
            state <= 3;
          else if (bump_left == 1 && bump_right == 1) // Lemming bumped on both sides simultaneously
            state <= 4;
          else if (dig == 1 && ground == 1) // Lemming starts digging
            state <= 6;
        end
        1: begin // Lemming is falling
          walk_left <= WALK_LEFT;
          walk_right <= ~WALK_LEFT;
          aaah <= 1;
          digging <= 0;
          
          if (ground == 1) // Lemming hits the ground
            state <= 0;
          else if (state < 16) // Lemming falls for less than 20 clock cycles
            state <= state + 1;
          else // Lemming falls for more than 20 clock cycles
            state <= 5;
        end
        2: begin // Lemming bumped on the left
          walk_left <= ~WALK_LEFT;
          walk_right <= WALK_LEFT;
          aaah <= 0;
          digging <= 0;
          
          if (ground == 0) // Lemming falls
            state <= 1;
          else if (bump_left == 1 && bump_right == 0) // Lemming bumped on the left again
            state <= 2;
          else if (bump_left == 0 && bump_right == 1) // Lemming bumped on the right
            state <= 3;
          else if (bump_left == 1 && bump_right == 1) // Lemming bumped on both sides simultaneously
            state <= 4;
          else if (dig == 1 && ground == 1) // Lemming starts digging
            state <= 6;
        end
        3: begin // Lemming bumped on the right
          walk_left <= WALK_LEFT;
          walk_right <= ~WALK_LEFT;
          aaah <= 0;
          digging <= 0;
          
          if (ground == 0) // Lemming falls
            state <= 1;
          else if (bump_left == 1 && bump_right == 0) // Lemming bumped on the left
            state <= 2;
          else if (bump_left == 0 && bump_right == 1) // Lemming bumped on the right again
            state <= 3;
          else if (bump_left == 1 && bump_right == 1) // Lemming bumped on both sides simultaneously
            state <= 4;
          else if (dig == 1 && ground == 1) // Lemming starts digging
            state <= 6;
        end
        4: begin // Lemming bumped on both sides simultaneously
          walk_left <= ~WALK_LEFT;
          walk_right <= WALK_LEFT;
          aaah <= 0;
          digging <= 0;
          
          if (ground == 0) // Lemming falls
            state <= 1;
          else if (bump_left == 1 && bump_right == 1) // Lemming bumped on both sides simultaneously again
            state <= 4;
          else if (bump_left == 1 && bump_right == 0) // Lemming bumped on the left
            state <= 2;
          else if (bump_left == 0 && bump_right == 1) // Lemming bumped on the right
            state <= 3;
          else if (dig == 1 && ground == 1) // Lemming starts digging
            state <= 6;
        end
        5: begin // Lemming splatters
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
        end
        6: begin // Lemming starts digging
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 0;
          digging <= 1;
          
          if (ground == 0) // Lemming falls
            state <= 1;
          else if (dig == 1 && ground == 1) // Lemming starts digging again
            state <= 6;
          else if (bump_left == 1 && bump_right == 0) // Lemming bumped on the left
            state <= 2;
          else if (bump_left == 0 && bump_right == 1) // Lemming bumped on the right
            state <= 3;
          else if (bump_left == 1 && bump_right == 1) // Lemming bumped on both sides simultaneously
            state <= 4;
        end
        default: state <= 0;
      endcase
    end
  end
  
endmodule
