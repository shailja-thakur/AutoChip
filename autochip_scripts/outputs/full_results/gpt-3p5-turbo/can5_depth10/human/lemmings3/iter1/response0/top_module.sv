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
      prev_state <= IDLE;
    end else begin
      prev_state <= state;
      case (state)
        IDLE: begin
          if (bump_left && !bump_right) begin
            state <= WALK_RIGHT;
          end else if (!bump_left && bump_right) begin
            state <= WALK_LEFT;
          end else if (!ground) begin
            state <= IDLE;
          end else if (dig) begin
            state <= IDLE;
          end
        end
        WALK_LEFT: begin
          if (bump_left && !bump_right) begin
            state <= WALK_RIGHT;
          end else if (!bump_left && bump_right) begin
            state <= IDLE;
          end else if (!ground) begin
            state <= IDLE;
          end else if (dig) begin
            state <= IDLE;
          end
        end
        WALK_RIGHT: begin
          if (bump_left && !bump_right) begin
            state <= WALK_RIGHT;
          end else if (!bump_left && bump_right) begin
            state <= IDLE;
          end else if (!ground) begin
            state <= IDLE;
          end else if (dig) begin
            state <= IDLE;
          end
        end
      endcase
    end
  end
  
  always @(state) begin
    case (prev_state)
      IDLE: begin
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
      end
      WALK_LEFT: begin
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
      end
      WALK_RIGHT: begin
        walk_left <= 1'b0;
        walk_right <= 1'b1;
        aaah <= 1'b0;
        digging <= 1'b0;
      end
    endcase
  end
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
     aaah <= 1'b0;
    end else begin
      if (ground && prev_state != IDLE) begin
        aaah <= 1'b1;
      end else begin
        aaah <= 1'b0;
      end
    end
  end
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      digging <= 1'b0;
    end else begin
      if (state == WALK_LEFT && dig) begin
        digging <= 1'b1;
      end else begin
        digging <= 1'b0;
      end
    end
  end
  
endmodule
