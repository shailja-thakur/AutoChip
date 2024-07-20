module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

  // State declaration
  reg [1:0] state;

  // State encoding
  parameter [1:0]
    WALK_LEFT = 2'b00,
    WALK_RIGHT = 2'b01;

  // Output declaration
  wire walk_left_out;
  wire walk_right_out;

  // Output logic
  assign walk_left_out = (state == WALK_LEFT);
  assign walk_right_out = (state == WALK_RIGHT);

  // State output assignment
  always @(posedge clk or posedge areset)
    if (areset)
      state <= WALK_LEFT;
    else begin
      case (state)
        WALK_LEFT:
          if (bump_right)
            state <= WALK_RIGHT;
        WALK_RIGHT:
          if (bump_left)
            state <= WALK_LEFT;
      endcase
    end

  // Assigning walk_left and walk_right outputs
  always @(walk_left_out or walk_right_out)
    if (walk_left_out)
      walk_left = 1;
    else
      walk_left = 0;

  always @(walk_left_out or walk_right_out)
    if (walk_right_out)
      walk_right = 1;
    else
      walk_right = 0;

endmodule
