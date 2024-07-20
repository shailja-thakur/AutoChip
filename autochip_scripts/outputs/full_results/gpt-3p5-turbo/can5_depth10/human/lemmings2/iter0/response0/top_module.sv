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
      state <= 2'b10;   // Initial state: walking left
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
    end else begin
      case (state)
        // Walking left state
        2'b10: begin
          if (ground == 0)
            state <= 2'b11;   // Transition to falling state
          else if (bump_right == 1)
            state <= 2'b01;   // Transition to walking right state
          else if (bump_left == 1)
            state <= 2'b10;   // Stay in walking left state
          else
            state <= 2'b10;   // Stay in walking left state
        end
        // Walking right state
        2'b01: begin
          if (ground == 0)
            state <= 2'b11;   // Transition to falling state
          else if (bump_left == 1)
            state <= 2'b10;   // Transition to walking left state
          else if (bump_right == 1)
            state <= 2'b01;   // Stay in walking right state
          else
            state <= 2'b01;   // Stay in walking right state
        end
        // Falling state
        2'b11: begin
          if (ground == 1)
            state <= (walk_left == 1) ? 2'b10 : 2'b01;   // Transition to previous walking direction
          else
            state <= 2'b11;   // Stay in falling state
        end
      endcase
    end
  end

  always @(state) begin
    case (state)
      2'b10: begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
      end
      2'b01: begin
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
      end
      2'b11: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
      end
    endcase
  end

endmodule
