module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
  // Define the states
  parameter WALK_LEFT = 0;
  parameter WALK_RIGHT = 1;

  // Define the state register
  reg [1:0] state;

  // Define the next state logic
  always @ (posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT; // Reset state to WALK_LEFT
    end else begin
      case(state)
        WALK_LEFT: begin
          if (bump_right) begin
            state <= WALK_RIGHT; // Transition to WALK_RIGHT if bumped on the right
          end
        end
        WALK_RIGHT: begin
          if (bump_left) begin
            state <= WALK_LEFT; // Transition to WALK_LEFT if bumped on the left
          end
        end
        default: begin
          state <= WALK_LEFT; // Default transition to WALK_LEFT
        end
      endcase
    end
  end

  // Define the output logic
  always @ (state) begin
    case(state)
      WALK_LEFT: begin
        walk_left = 1; // Lemming is walking left
        walk_right = 0;
      end
      WALK_RIGHT: begin
        walk_left = 0;
        walk_right = 1; // Lemming is walking right
      end
      default: begin
        walk_left = 1;
        walk_right = 0;
      end
    endcase
  end

endmodule
