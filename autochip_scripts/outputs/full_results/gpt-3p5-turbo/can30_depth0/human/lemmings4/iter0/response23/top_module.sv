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

parameter WALK_LEFT = 3'b000;
parameter WALK_RIGHT = 3'b001;
parameter FALL = 3'b010;
parameter DIG = 3'b011;
parameter SPLATTER = 3'b100;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= WALK_LEFT;
  end else begin
    case (state)
      WALK_LEFT:
        if (bump_right) begin
          state <= WALK_RIGHT;
        end else if (!ground) begin
          state <= FALL;
        end else if (dig) begin
          state <= DIG;
        end
      WALK_RIGHT:
        if (bump_left) begin
          state <= WALK_LEFT;
        end else if (!ground) begin
          state <= FALL;
        end else if (dig) begin
          state <= DIG;
        end
      FALL:
        if (ground) begin
          if (state == FALL) begin
            state <= WALK_LEFT;
          end else begin
            state <= state;
          end
        end else if (state < SPLATTER) begin
          state <= FALL + 1;
        end
      DIG:
        if (!ground) begin
          state <= FALL;
        end else if (dig) begin
          state <= DIG;
        end else begin
          state <= WALK_LEFT;
        end
    endcase
  end
end

assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL) && ground;
assign digging = (state == DIG);

endmodule
