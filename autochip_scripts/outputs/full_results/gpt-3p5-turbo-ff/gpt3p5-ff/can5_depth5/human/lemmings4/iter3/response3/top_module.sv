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
  reg [6:0] count; // Increased bit width to accommodate a larger count value
  reg splat; // New
  
  parameter WALK_LEFT = 5'b00001;
  parameter WALK_RIGHT = 5'b00010;
  parameter FALL = 5'b00100;
  parameter DIG = 5'b01000;
  parameter SPLATTER = 5'b10000;
  parameter DEFAULT = 5'b00000;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= WALK_LEFT;
    else
      state <= next_state;
  end
  
  always @(state or bump_left or bump_right or ground or dig) begin
    count <= count + 1; // New
    case (state)
      WALK_LEFT: begin
        if (bump_right) next_state = WALK_RIGHT;
        else if (ground == 0) next_state = FALL;
        else if (dig) next_state = DIG;
        else next_state = WALK_LEFT;
      end
      WALK_RIGHT: begin
        if (bump_left) next_state = WALK_LEFT;
        else if (ground == 0) next_state = FALL;
        else if (dig) next_state = DIG;
        else next_state = WALK_RIGHT;
      end
      FALL: begin
        if (ground == 1) next_state = state[3:0];
        else if (count >= 20) next_state = SPLATTER; // Changed to >= to ensure proper transition to splatter state
        else next_state = FALL;
      end
      DIG: begin
        if (ground == 0) next_state = FALL;
        else if (bump_left || bump_right) next_state = state;
        else next_state = DIG;
      end
      SPLATTER: begin
        next_state = SPLATTER;
      end
      DEFAULT: begin
        next_state = WALK_LEFT;
      end
    endcase
  end
  
  always @(state) begin
    case (state)
      WALK_LEFT: begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        splat = 0; // New
      end
      WALK_RIGHT: begin
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
        digging = 0;
        splat = 0; // New
      end
      FALL: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
        digging = 0;
        splat = 0; // New
      end
      DIG: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 1;
        splat = 0; // New
      end
      SPLATTER: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        splat = 1; // New
      end
      DEFAULT: begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        splat = 0; // New
      end
    endcase
  end
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      count <= count;
      splat <= 0; // New
    end else if (state != next_state) begin
      count <= 0;
      splat <= 0; // New
    end else if (state == FALL && ground == 0) begin
      count <= count + 1;
      splat <= 0; // New
    end else if (splat == 1 && ground == 1) begin // New
      splat <= 0;
    end else if (count >= 20) begin // New
      splat <= 1;
    end else begin
      count <= 0;
      splat <= 0;
    end
  end

endmodule
