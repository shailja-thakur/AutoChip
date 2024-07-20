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
      state <= next_state;
      case (state)
        IDLE: begin
          if (bump_left && !bump_right) begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
          end else if (!bump_left && bump_right) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
          end else if (bump_left && bump_right) begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
          end else if (ground == 0) begin
            aaah <= 1'b1;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
          end else if (ground && dig && state != IDLE) begin
            digging <= 1'b1;
          end else if (ground && dig && state == IDLE) begin
            digging <= 1'b1;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
          end else if (!ground && !dig && prev_state == WALK_LEFT) begin
            aaah <= 1'b1;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
          end else if (!ground && !dig && prev_state == WALK_RIGHT) begin
            aaah <= 1'b1;
            walk_left <= 1'b0;
            walk_right <= 1'b1;
          end
        end
        
        WALK_LEFT: begin
          if (bump_left) begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
          end else if (!ground) begin
            aaah <= 1'b1;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
          end else if (ground && dig && state != WALK_LEFT) begin
            digging <= 1'b1;
          end else if (ground && dig && state == WALK_LEFT) begin
            digging <= 1'b1;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
          end
        end
        
        WALK_RIGHT: begin
          if (bump_right) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
          end else if (!ground) begin
            aaah <= 1'b1;
            walk_left <= 1'b0;
            walk_right <= 1'b1;
          end else if (ground && dig && state != WALK_RIGHT) begin
            digging <= 1'b1;
          end else if (ground && dig && state == WALK_RIGHT) begin
            digging <= 1'b1;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
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
