module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

  // Define state enumeration
  typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT
  } state_t;

  // Define signals
  reg state_t state;
  wire next_state;

  // Synchronous always block for state transition and output assignment
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
    end else begin
      state <= next_state;
    end
  end

  // Combinational logic block for next state logic
  always_comb begin
    case (state)
      WALK_LEFT:
        if (bump_left) begin
          next_state = WALK_RIGHT;
        end else if (bump_right) begin
          next_state = WALK_LEFT;
        end else begin
          next_state = WALK_LEFT;
        end
      WALK_RIGHT:
        if (bump_left) begin
          next_state = WALK_RIGHT;
        end else if (bump_right) begin
          next_state = WALK_LEFT;
        end else begin
          next_state = WALK_RIGHT;
        end
      default:
        next_state = WALK_LEFT;
    endcase
  end

  // Assign outputs based on current state
  assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
  assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;

endmodule
