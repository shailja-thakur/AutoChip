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
  
  reg [1:0] state;
  reg [1:0] next_state;
  
  parameter [1:0] WALK_LEFT = 2'b00;
  parameter [1:0] WALK_RIGHT = 2'b01;
  parameter [1:0] FALL = 2'b10;
  parameter [1:0] DIG = 2'b11;
  
  reg walk_left;
  reg walk_right;
  reg aaah;
  reg digging;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
    end else begin
      state <= next_state;
      walk_left <= (state == WALK_LEFT);
      walk_right <= (state == WALK_RIGHT);
      aaah <= (state == FALL);
      digging <= (state == DIG);
    end
  end
  
  always @(state, bump_left, bump_right, ground, dig) begin
    case (state)
      WALK_LEFT: begin
        if (bump_left && !bump_right)
          next_state = WALK_RIGHT;
        else if (!ground)
          next_state = FALL;
        else if (dig && ground)
          next_state = DIG;
        else
          next_state = WALK_LEFT;
      end
      
      WALK_RIGHT: begin
        if (!bump_left && bump_right)
          next_state = WALK_LEFT;
        else if (!ground)
          next_state = FALL;
        else if (dig && ground)
          next_state = DIG;
        else
          next_state = WALK_RIGHT;
      end
      
      FALL: begin
        if (ground)
          next_state = state;
        else if (dig && ground)
          next_state = DIG;
        else
          next_state = FALL;
      end
      
      DIG: begin
        if (!ground)
          next_state = FALL;
        else
          next_state = DIG;
      end
    endcase
  end
  
endmodule
