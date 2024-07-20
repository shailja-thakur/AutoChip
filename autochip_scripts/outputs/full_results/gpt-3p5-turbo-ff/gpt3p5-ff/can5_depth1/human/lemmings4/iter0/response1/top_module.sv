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
  reg [4:0] state;

  localparam IDLE = 0;
  localparam WALK_LEFT = 1;
  localparam WALK_RIGHT = 2;
  localparam FALL_LEFT = 3;
  localparam FALL_RIGHT = 4;
  localparam DIG_LEFT = 5;
  localparam DIG_RIGHT = 6;
  localparam SPLATTER = 7;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= WALK_LEFT;
    else begin
      case (state)
        IDLE:
          if (ground)
            state <= WALK_LEFT;
          else if (state == IDLE && dig && ground)
            state <= DIG_LEFT;
        WALK_LEFT:
          if (bump_right)
            state <= WALK_RIGHT;
          else if (!ground)
            state <= FALL_LEFT;
          else if (dig && ground)
            state <= DIG_LEFT;
        WALK_RIGHT:
          if (bump_left)
            state <= WALK_LEFT;
          else if (!ground)
            state <= FALL_RIGHT;
          else if (dig && ground)
            state <= DIG_RIGHT;
        FALL_LEFT:
          if (!ground)
            state <= FALL_LEFT;
          else if (dig && ground)
            state <= DIG_LEFT;
          else if (bump_right)
            state <= WALK_RIGHT;
          else if (state == IDLE)
            state <= WALK_LEFT;
          else
            state <= IDLE;
        FALL_RIGHT:
          if (!ground)
            state <= FALL_RIGHT;
          else if (dig && ground)
            state <= DIG_RIGHT;
          else if (bump_left)
            state <= WALK_LEFT;
          else if (state == IDLE)
            state <= WALK_LEFT;
          else
            state <= IDLE;
        DIG_LEFT:
          if (!ground)
            state <= DIG_LEFT;
          else
            state <= IDLE;
        DIG_RIGHT:
          if (!ground)
            state <= DIG_RIGHT;
          else
            state <= IDLE;
        SPLATTER:
          state <= SPLATTER;
      endcase
    end
  end

  assign walk_left = (state == WALK_LEFT || state == DIG_LEFT || state == FALL_LEFT) ? 1'b1 : 1'b0;
  assign walk_right = (state == WALK_RIGHT || state == DIG_RIGHT || state == FALL_RIGHT) ? 1'b1 : 1'b0;
  assign aaah = (state == FALL_LEFT || state == FALL_RIGHT || state == SPLATTER) ? 1'b1 : 1'b0;
  assign digging = (state == DIG_LEFT || state == DIG_RIGHT) ? 1'b1 : 1'b0;
endmodule
