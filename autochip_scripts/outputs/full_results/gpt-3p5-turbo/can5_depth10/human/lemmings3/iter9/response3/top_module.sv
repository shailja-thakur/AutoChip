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
  reg [1:0] next_state;

  parameter IDLE = 2'b00;
  parameter WALK_LEFT = 2'b01;
  parameter WALK_RIGHT = 2'b10;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= IDLE;
      walk_left <= 1'b1;
      walk_right <= 1'b0;
      aaah <= 1'b0;
      digging <= 1'b0;
    end else begin
      state <= next_state;
      
      case (state)
        IDLE: begin
          if (bump_right && !bump_left) begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
            aaah <= 1'b0;
            digging <= 1'b0;
            next_state = WALK_RIGHT;
          end else if (bump_left && !bump_right) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
            next_state = WALK_LEFT;
          end else if (!ground) begin
            if (prev_state == WALK_LEFT) begin // Falling after WALK_LEFT
              aaah <= 1'b1;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              digging <= 1'b0;
              next_state = IDLE;
            end else if (prev_state == WALK_RIGHT) begin // Falling after WALK_RIGHT
              aaah <= 1'b1;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              digging <= 1'b0;
              next_state = IDLE;
            end else if (prev_state == IDLE) begin // Falling after IDLE
              aaah <= 1'b1;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              digging <= 1'b0;
              next_state = IDLE;
            end
          end else if (prev_state == WALK_LEFT && dig && ground) begin // Digging after WALK_LEFT
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            next_state = IDLE;
          end else if (prev_state == WALK_RIGHT && dig && ground) begin // Digging after WALK_RIGHT
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            next_state = IDLE;
          end else if (prev_state == IDLE && dig && ground) begin // Digging after IDLE
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            next_state = IDLE;
          end else begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
            next_state = IDLE;
          end
        end
        
        WALK_LEFT: begin
          if (bump_right) begin
            next_state = IDLE;
          end else if (!ground) begin
            if (prev_state == WALK_LEFT) begin // Falling after WALK_LEFT
              aaah <= 1'b1;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              digging <= 1'b0;
              next_state = IDLE;
            end
          end else if (prev_state == WALK_LEFT && dig && ground) begin // Digging after WALK_LEFT
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            next_state = IDLE;
          end else begin
            next_state = WALK_LEFT;
          end
        end
        
        WALK_RIGHT: begin
          if (bump_left) begin
            next_state = IDLE;
          end else if (!ground) begin
            if (prev_state == WALK_RIGHT) begin // Falling after WALK_RIGHT
              aaah <= 1'b1;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              digging <= 1'b0;
              next_state = IDLE;
            end
          end else if (prev_state == WALK_RIGHT && dig && ground) begin // Digging after WALK_RIGHT
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            next_state = IDLE;
          end else begin
            next_state = WALK_RIGHT;
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
