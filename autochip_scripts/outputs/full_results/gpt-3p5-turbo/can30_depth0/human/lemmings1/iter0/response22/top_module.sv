module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

  // Define state enum
  typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT
  } state_t;

  // Declare state variable
  reg [1:0] state;

  // Define state transition and output logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset state to walk left
      state <= WALK_LEFT;
    end else begin
      case(state)
        WALK_LEFT: begin
          if (bump_right) begin
            // Switch to walk right if bumped on the right
            state <= WALK_RIGHT;
          end
        end
        WALK_RIGHT: begin
          if (bump_left) begin
            // Switch to walk left if bumped on the left
            state <= WALK_LEFT;
          end
        end
      endcase
    end
  end

  // Define output logic
  always @(state or bump_left or bump_right) begin
    case(state)
      WALK_LEFT: begin
        walk_left = 1;
        walk_right = 0;
      end
      WALK_RIGHT: begin
        walk_left = 0;
        walk_right = 1;
      end
    endcase
  end

endmodule
