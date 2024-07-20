module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
);

  reg [1:0] state;
  reg walk_left;
  reg walk_right;
  reg aaah;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b10; // Initial state is walking left
    end else begin
      case(state)
        2'b10: // Walking left state
          begin
            if (bump_left && !bump_right) // Bumped on the left
              state <= 2'b01; // Change to walking right state
            else if (!bump_left && !bump_right) // No bump, keep walking left
              state <= 2'b10; // Stay in walking left state
            else if (bump_right && !bump_left) // Bumped on the right
              state <= 2'b00; // Change to walking left state
            else if (bump_left && bump_right) // Bumped on both sides
              state <= 2'b01; // Change to walking right state
          end
        2'b01: // Walking right state
          begin
            if (bump_right && !bump_left) // Bumped on the right
              state <= 2'b00; // Change to walking left state
            else if (!bump_left && !bump_right) // No bump, keep walking right
              state <= 2'b01; // Stay in walking right state
            else if (bump_left && !bump_right) // Bumped on the left
              state <= 2'b10; // Change to walking left state
            else if (bump_left && bump_right) // Bumped on both sides
              state <= 2'b00; // Change to walking left state
          end
        2'b00: // Falling state
          begin
            if (ground) // Ground reappears
              state <= (state == 2'b10) ? 2'b10 : 2'b01; // Resume walking in the same direction as before the fall
          end
        default:
          state <= 2'b10; // Error state, default to walking left
      endcase
    end
  end

  always @(state, ground) begin
    case(state)
      2'b10: // Walking left state
        begin
          walk_left = 1;
          walk_right = 0;
          aaah = 0;
        end
      2'b01: // Walking right state
        begin
          walk_left = 0;
          walk_right = 1;
          aaah = 0;
        end
      2'b00: // Falling state
        begin
          walk_left = 0;
          walk_right = 0;
          aaah = 1;
        end
      default:
        begin
          walk_left = 1;
          walk_right = 0;
          aaah = 0;
        end
    endcase
  end

endmodule
