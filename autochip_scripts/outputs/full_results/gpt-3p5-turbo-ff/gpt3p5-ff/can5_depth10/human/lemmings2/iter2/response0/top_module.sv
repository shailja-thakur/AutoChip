module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output reg walk_left,
  output reg walk_right,
  output reg aaah
);

  reg [1:0] state;
  parameter WALK_LEFT = 2'b00;
  parameter WALK_RIGHT = 2'b01;
  parameter FALLING_LEFT = 2'b10;
  parameter FALLING_RIGHT = 2'b11;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
    end else begin
      case (state)
        WALK_LEFT: begin
          if (bump_left && !bump_right && ground) begin
            state <= WALK_RIGHT;
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
          end else if (!bump_left && bump_right && !ground) begin
            state <= FALLING_RIGHT;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
          end else if (!bump_left && !bump_right && !ground) begin
            state <= FALLING_LEFT;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
          end else begin
            state <= WALK_LEFT;
          end
        end
        WALK_RIGHT: begin
          if (bump_left && !bump_right && ground) begin
            state <= FALLING_LEFT;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
          end else if (!bump_left && bump_right && !ground) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
          end else if (!bump_left && !bump_right && !ground) begin
            state <= FALLING_RIGHT;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
          end else begin
            state <= WALK_RIGHT;
          end
        end
        FALLING_LEFT: begin
          if (ground) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
          end else begin
            state <= FALLING_LEFT;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
          end
        end
        FALLING_RIGHT: begin
          if (ground) begin
            state <= WALK_RIGHT;
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
          end else begin
            state <= FALLING_RIGHT;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
          end
        end
        default: begin
          state <= WALK_LEFT;
          walk_left <= 1;
          walk_right <= 0;
          aaah <= 0;
        end
      endcase
    end
  end

endmodule
