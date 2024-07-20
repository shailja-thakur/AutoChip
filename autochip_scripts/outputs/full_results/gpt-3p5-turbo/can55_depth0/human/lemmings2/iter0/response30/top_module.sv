module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output reg walk_left,
  output reg walk_right,
  output aaah
);

  // Define the states
  parameter IDLE = 2'b00;
  parameter WALK_LEFT = 2'b01;
  parameter WALK_RIGHT = 2'b10;

  // Define the internal state variable
  reg [1:0] state;

  // Define the outputs
  reg walk_left;
  reg walk_right;
  reg aaah;

  // Synchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= IDLE;
    else begin
      case (state)
        IDLE:
          if (bump_left && bump_right)
            state <= IDLE;
          else if (bump_left)
            state <= WALK_RIGHT;
          else if (bump_right)
            state <= WALK_LEFT;
          else if (!ground)
            state <= IDLE;
          else
            state <= WALK_LEFT;
        WALK_LEFT:
          if (bump_right)
            state <= WALK_RIGHT;
          else if (!ground)
            state <= IDLE;
          else
            state <= WALK_LEFT;
        WALK_RIGHT:
          if (bump_left)
            state <= WALK_LEFT;
          else if (!ground)
            state <= IDLE;
          else
            state <= WALK_RIGHT;
        default:
          state <= IDLE;
      endcase
    end
  end

  // Define the outputs based on the current state
  always @(state) begin
    case (state)
      IDLE:
        begin
          walk_left = 1'b1;
          walk_right = 1'b0;
          aaah = 1'b0;
        end
      WALK_LEFT:
        begin
          walk_left = 1'b1;
          walk_right = 1'b0;
          aaah = 1'b0;
        end
      WALK_RIGHT:
        begin
          walk_left = 1'b0;
          walk_right = 1'b1;
          aaah = 1'b0;
        end
      default:
        begin
          walk_left = 1'b1;
          walk_right = 1'b0;
          aaah = 1'b0;
        end
    endcase
  end

endmodule
