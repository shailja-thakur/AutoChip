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
    end else begin
      case (state)
        WALK_LEFT: begin
          if (bump_left) begin
            state <= WALK_RIGHT;
          end else if (bump_right) begin
            state <= FALLING_RIGHT;
          end else if (ground == 0) begin
            state <= FALLING_LEFT;
          end else begin
            state <= WALK_LEFT;
          end
        end
        WALK_RIGHT: begin
          if (bump_right) begin
            state <= WALK_LEFT;
          end else if (bump_left) begin
            state <= FALLING_LEFT;
          end else if (ground == 0) begin
            state <= FALLING_RIGHT;
          end else begin
            state <= WALK_RIGHT;
          end
        end
        FALLING_LEFT: begin
          if (ground == 1) begin
            state <= WALK_LEFT;
          end else begin
            state <= FALLING_LEFT;
          end
        end
        FALLING_RIGHT: begin
          if (ground == 1) begin
            state <= WALK_RIGHT;
          end else begin
            state <= FALLING_RIGHT;
          end
        end
        default: state <= WALK_LEFT;
      endcase
    end
  end

  always @(state) begin
    case (state)
      WALK_LEFT: begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
      end
      WALK_RIGHT: begin
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
      end
      FALLING_LEFT: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
      end
      FALLING_RIGHT: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
      end
      default: begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
      end
    endcase
  end

endmodule
