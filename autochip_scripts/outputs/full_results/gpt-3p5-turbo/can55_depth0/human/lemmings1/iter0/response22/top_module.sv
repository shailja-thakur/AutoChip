module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

  reg [1:0] state;

  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= 2'b01;  // Reset to walk_left state
    else
    begin
      case (state)
        2'b01:  // walking left state
        begin
          if (bump_right)
            state <= 2'b10;  // switch to walking right state
          else if (bump_left)
            state <= 2'b01;  // stay in walking left state
        end

        2'b10:  // walking right state
        begin
          if (bump_left)
            state <= 2'b01;  // switch to walking left state
          else if (bump_right)
            state <= 2'b10;  // stay in walking right state
        end

        default:
          state <= 2'b01;
      endcase
    end
  end

  assign walk_left = (state == 2'b01);
  assign walk_right = (state == 2'b10);

endmodule
