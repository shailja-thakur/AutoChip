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
      case (state)
        IDLE: begin
          if (bump_left && !bump_right) begin
            state <= WALK_RIGHT;
          end else if (!bump_left && bump_right) begin
            state <= WALK_LEFT;
          end else if (!ground && prev_state != IDLE) begin
            state <= IDLE;
          end else if (!ground && prev_state == IDLE) begin
            aaah <= 1'b1;
            state <= IDLE;
          end else if (ground && dig && prev_state != IDLE) begin
            state <= IDLE;
          end else if (ground && dig && prev_state == IDLE) begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            state <= IDLE;
          end else if (!ground && !dig && prev_state == WALK_LEFT) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
            state <= WALK_LEFT;
          end else if (!ground && !dig && prev_state == WALK_RIGHT) begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
            aaah <= 1'b0;
            digging <= 1'b0;
            state <= WALK_RIGHT;
          end
        end
        
        WALK_LEFT: begin
          if (bump_right) begin
            state <= IDLE;
          end else if (!ground && prev_state != WALK_LEFT) begin
            state <= IDLE;
          end else if (!ground && prev_state == WALK_LEFT) begin
            aaah <= 1'b1;
            state <= IDLE;
          end else if (ground && dig && prev_state != WALK_LEFT) begin
            state <= IDLE;
          end else if (ground && dig && prev_state == WALK_LEFT) begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            state <= IDLE;
          end
        end
        
        WALK_RIGHT: begin
          if (bump_left) begin
            state <= IDLE;
          end else if (!ground && prev_state != WALK_RIGHT) begin
            state <= IDLE;
          end else if (!ground && prev_state == WALK_RIGHT) begin
            aaah <= 1'b1;
            state <= IDLE;
          end else if (ground && dig && prev_state != WALK_RIGHT) begin
            state <= IDLE;
          end else if (ground && dig && prev_state == WALK_RIGHT) begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            state <= IDLE;
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
