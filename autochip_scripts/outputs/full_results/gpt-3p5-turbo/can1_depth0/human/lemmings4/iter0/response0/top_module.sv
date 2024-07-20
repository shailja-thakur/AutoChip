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
  
  reg [4:0] state;
  reg [4:0] next_state;
  
  parameter WALK_LEFT = 5'b00001;
  parameter WALK_RIGHT = 5'b00010;
  parameter FALL = 5'b00100;
  parameter DIG = 5'b01000;
  parameter SPLATTER = 5'b10000;
  
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
  
  always @* begin
    next_state = state;
    
    case (state)
      WALK_LEFT:
        if (bump_right)
          next_state = WALK_RIGHT;
        else if (!ground)
          next_state = FALL;
        else if (dig)
          next_state = DIG;
      WALK_RIGHT:
        if (bump_left)
          next_state = WALK_LEFT;
        else if (!ground)
          next_state = FALL;
        else if (dig)
          next_state = DIG;
      FALL:
        if (ground)
          next_state = walk_left ? WALK_LEFT : WALK_RIGHT;
      DIG:
        if (!ground)
          next_state = FALL;
        else if (dig)
          next_state = DIG;
      SPLATTER:
        // no next state, remains in SPLATTER state
    endcase
  end
  
  always @(posedge clk or posedge areset) begin
    if (areset || (state == SPLATTER)) begin
      aaah <= 0;
      walk_left <= 0;
      walk_right <= 0;
      digging <= 0;
    end else begin
      case (state)
        WALK_LEFT:
          if (bump_left && bump_right)
            next_state = SPLATTER;
        WALK_RIGHT:
          if (bump_left && bump_right)
            next_state = SPLATTER;
        FALL:
          if (ground)
            next_state = walk_left ? WALK_LEFT : WALK_RIGHT;
        DIG:
          if (!ground)
            next_state = FALL;
      endcase
    end
  end
endmodule
