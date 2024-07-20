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
  reg falling;
  
  parameter IDLE = 2'b00;
  parameter WALK_LEFT = 2'b01;
  parameter WALK_RIGHT = 2'b10;
  parameter FALL = 2'b11;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= IDLE;
      walk_left <= 1'b1;
      walk_right <= 1'b0;
      aaah <= 1'b0;
      digging <= 1'b0;
      falling <= 1'b0;
    end else begin
      case (state)
        
        IDLE: begin
          if (bump_left && !bump_right) begin
            state <= WALK_RIGHT;
          end else if (!bump_left && bump_right) begin
            state <= WALK_LEFT;
          end else if (!ground && !falling) begin
            aaah <= 1'b1;
            state <= FALL;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b0;
            falling <= 1'b1;
          end else if (ground && dig) begin
            if (falling) begin
              state <= FALL;
            end else begin
              state <= IDLE;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              aaah <= 1'b0;
              digging <= 1'b1;
            end
          end else begin
            state <= IDLE;
            aaah <= 1'b0;
            digging <= 1'b0;
            falling <= 1'b0;
            if (walk_left && !walk_right) begin
              walk_left <= 1'b1;
              walk_right <= 1'b0;
            end else if (!walk_left && walk_right) begin
              walk_left <= 1'b0;
              walk_right <= 1'b1;
            end else begin
              walk_left <= 1'b0;
              walk_right <= 1'b0;
            end
          end
        end
        
        FALL: begin
          if (ground) begin
            if (prev_state == WALK_LEFT) begin
              walk_left <= 1'b1;
              walk_right <= 1'b0;
            end else if (prev_state == WALK_RIGHT) begin
              walk_left <= 1'b0;
              walk_right <= 1'b1;
            end else begin
              walk_left <= 1'b0;
              walk_right <= 1'b0;
            end
            aaah <= 1'b0;
            digging <= 1'b0;
            falling <= 1'b0;
            state <= IDLE;
          end else begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b1;
            digging <= 1'b0;
            state <= FALL;
          end
        end
        
        WALK_LEFT: begin
          if (bump_right) begin
            state <= IDLE;
          end else if (!ground && !falling) begin
            aaah <= 1'b1;
            state <= FALL;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b0;
            falling <= 1'b1;
          end else if (ground && dig) begin
            if (falling) begin
              state <= FALL;
            end else begin
              state <= IDLE;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              aaah <= 1'b0;
              digging <= 1'b1;
            end
          end else begin
            state <= WALK_LEFT;
            aaah <= 1'b0;
            digging <= 1'b0;
            falling <= 1'b0;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
          end
        end
        
        WALK_RIGHT: begin
          if (bump_left) begin
            state <= IDLE;
          end else if (!ground && !falling) begin
            aaah <= 1'b1;
            state <= FALL;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b0;
            falling <= 1'b1;
          end else if (ground && dig) begin
            if (falling) begin
              state <= FALL;
            end else begin
              state <= IDLE;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              aaah <= 1'b0;
              digging <= 1'b1;
            end
          end else begin
            state <= WALK_RIGHT;
            aaah <= 1'b0;
            digging <= 1'b0;
            falling <= 1'b0;
            walk_left <= 1'b0;
            walk_right <= 1'b1;
          end
        end
        
      endcase
    end
  end
  
  always @(negedge clk or posedge areset) begin
    if (areset) begin
      prev_state <= IDLE;
    end else begin
      prev_state <= state;
    end
  end
  
endmodule
