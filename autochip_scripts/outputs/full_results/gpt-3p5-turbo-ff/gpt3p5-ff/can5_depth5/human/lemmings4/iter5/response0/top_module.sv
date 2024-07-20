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

  reg [3:0] state;
  reg [3:0] next_state;
  reg [6:0] count;
  reg splat;
  
  parameter WALK_LEFT = 4'b0001;
  parameter WALK_RIGHT = 4'b0010;
  parameter FALL = 4'b0100;
  parameter DIG = 4'b1000;
  parameter SPLATTER = 4'b1111;
  parameter DEFAULT = 4'b0000;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= WALK_LEFT;
    else
      state <= next_state;
  end
  
  always @(*) begin
    next_state = state;
    case (state)
      WALK_LEFT: begin
        if (bump_right) next_state = WALK_RIGHT;
        else if (ground == 0) next_state = FALL;
        else if (dig) next_state = DIG;
      end
      WALK_RIGHT: begin
        if (bump_left) next_state = WALK_LEFT;
        else if (ground == 0) next_state = FALL;
        else if (dig) next_state = DIG;
      end
      FALL: begin
        if (ground == 1) begin
          if (state == DIG || count >= 20) next_state = SPLATTER;
        end
        else if (count == 0) next_state = FALL;
      end
      DIG: begin
        if (bump_left || bump_right) next_state = state;
        else if (ground == 0) next_state = FALL;
      end
      SPLATTER: begin
        if (ground == 1) next_state = WALK_LEFT;
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
        aaah = (ground == 0);
        digging = 0;
        splat = 0;
      end
      WALK_RIGHT: begin
        walk_left = 0;
        walk_right = 1;
        aaah = (ground == 0);
        digging = 0;
        splat = 0;
      end
      FALL: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
        digging = 0;
        splat = 0;
      end
      DIG: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 1;
        splat = 0;
      end
      SPLATTER: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        splat = 1;
      end
      DEFAULT: begin
        walk_left = 1;
        walk_right = 0;
        aaah = (ground == 0);
        digging = 0;
        splat = 0;
      end
    endcase
  end
  
  always @(posedge clk) begin
    if (areset) begin
      count <= 0;
      splat <= 0;
    end else if (state != next_state) begin
      count <= 0;
      splat <= 0;
    end else if (state == FALL && ground == 0) begin
      count <= count + 1;
    end else if (ground == 1 && (state == FALL || (state == DIG && count >= 20))) begin
      count <= 0;
    end else if (ground == 1) begin // New condition
      count <= count;
    end else begin
      count <= 0;
    end
  end

endmodule
