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
  reg prev_state;
  reg fall;
  reg [1:0] next_state;
  reg [1:0] next_prev_state;
  
  parameter IDLE = 2'b00;
  parameter WALK_LEFT = 2'b01;
  parameter WALK_RIGHT = 2'b10;
  parameter FALL = 2'b11;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= IDLE;
      walk_left <= 0;
      walk_right <= 1;
      aaah <= 0;
      digging <= 0;
      fall <= ground;
    end else begin
      state <= next_state;
      prev_state <= next_prev_state;
    end
  end
  
  always @(state, prev_state, bump_left, bump_right, ground, dig, fall) begin
    next_prev_state = prev_state;
    
    case (state)
      IDLE: begin
        if (bump_left && !bump_right) begin
          next_state = WALK_RIGHT;
          next_prev_state = IDLE;
        end else if (!bump_left && bump_right) begin
          next_state = WALK_LEFT;
          next_prev_state = IDLE;
        end else if (bump_left && bump_right) begin
          next_state = IDLE;
          next_prev_state = IDLE;
        end else if (!fall && !ground) begin
          next_state = FALL;
          next_prev_state = IDLE;
        end else if (fall && ground) begin
          next_state = IDLE;
          next_prev_state = FALL;
        end else if (ground && dig && !fall) begin
          next_state = IDLE;
          next_prev_state = IDLE;
        end
      end
      
      WALK_LEFT: begin
        if (bump_right) begin
          next_state = IDLE;
          next_prev_state = WALK_LEFT;
        end else if (!fall && !ground) begin
          next_state = FALL;
          next_prev_state = WALK_LEFT;
        end else if (fall && ground) begin
          aaah <= 1;
          next_state = IDLE;
          next_prev_state = FALL;
        end else if (ground && dig && !fall) begin
          next_state = IDLE;
          next_prev_state = WALK_LEFT;
        end
      end
      
      WALK_RIGHT: begin
        if (bump_left) begin
          next_state = IDLE;
          next_prev_state = WALK_RIGHT;
        end else if (!fall && !ground) begin
          next_state = FALL;
          next_prev_state = WALK_RIGHT;
        end else if (fall && ground) begin
          aaah <= 1;
          next_state = IDLE;
          next_prev_state = FALL;
        end else if (ground && dig && !fall) begin
          next_state = IDLE;
          next_prev_state = WALK_RIGHT;
        end
      end
      
      FALL: begin
        if (ground) begin
          next_state = IDLE;
          next_prev_state = FALL;
        end
      end
    endcase
  end
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      walk_left <= 0;
      walk_right <= 1;
      aaah <= 0;
      digging <= 0;
    end else begin
      case (state)
        IDLE: begin
          walk_left <= 1;
          walk_right <= 0;
        end
        WALK_LEFT: begin
          walk_left <= 1;
          walk_right <= 0;
        end
        WALK_RIGHT: begin
          walk_left <= 0;
          walk_right <= 1;
        end
        FALL: begin
          walk_left <= 0;
          walk_right <= 1;
          aaah <= 1;
        end
      endcase
    end
  end
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      fall <= ground;
    end else begin
      fall <= ground;
    end
  end
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      digging <= 0;
    end else begin
      if (state == IDLE && dig && ground && !fall) begin
        digging <= 1;
      end else begin
        digging <= 0;
      end
    end
  end
  
endmodule
