module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

  reg [1:0] state;
  reg walk_left;
  reg walk_right;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b10; // Initializing state to walking left
    end else begin
      case(state)
        2'b00: begin // Walking right state
          if (bump_left || (bump_left && bump_right))
            state <= 2'b01; // Switch to walking left state
        end
        2'b01: begin // Walking left state
          if (bump_right || (bump_left && bump_right))
            state <= 2'b00; // Switch to walking right state
        end
        default: begin // Default case, should never be reached
          state <= 2'b10; // Reset to initial state
        end
      endcase
    end
  end
  
  always @(state) begin
    case(state)
      2'b00: begin // Walking right state
        walk_left = 0;
        walk_right = 1;
      end
      2'b01: begin // Walking left state
        walk_left = 1;
        walk_right = 0;
      end
      default: begin // Default case, should never be reached
        walk_left = 1;
        walk_right = 0;
      end
    endcase
  end
endmodule
