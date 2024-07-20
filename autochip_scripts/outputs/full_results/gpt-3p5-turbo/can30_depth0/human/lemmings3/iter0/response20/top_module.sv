module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output walk_left,
  output walk_right,
  output aaah,
  output digging
);

  reg [1:0] state;
  wire bump_both;
  wire bumped;

  assign bump_both = bump_left & bump_right;
  assign bumped = bump_left | bump_right;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b10; // Starting state: walk_left
    else begin
      case (state)
        2'b00: // falling state
          begin
            if (ground)
              state <= (bumped & ~bump_both) ? 2'b00 : 2'b01; // continue falling if bumped on a single side or falling if bumped on both sides
          end
        2'b01: // digging state
          begin
            if (ground)
              state <= 2'b10; // walking state
            else if (dig)
              state <= 2'b01; // continue digging
          end
        2'b10: // walking state
          begin
            if (~ground)
              state <= 2'b00; // falling state
            else if (bumped)
              state <= ~state; // switch directions
            else if (dig)
              state <= 2'b01; // digging state
          end
        default:
          state <= 2'b10; // default to walking state
      endcase
    end
  end

  assign walk_left = (state == 2'b10);
  assign walk_right = (state == 2'b01);
  assign aaah = (state == 2'b00);
  assign digging = (state == 2'b01);

endmodule
