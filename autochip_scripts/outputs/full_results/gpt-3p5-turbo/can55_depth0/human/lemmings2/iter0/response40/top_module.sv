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
   reg prev_ground;

   parameter WALK_LEFT = 2'b00;
   parameter WALK_RIGHT = 2'b01;
   parameter FALL = 2'b10;

   always @(posedge clk or posedge areset) begin
      if (areset)
         state <= WALK_LEFT;
      else begin
         case (state)
            WALK_LEFT:
               if (bump_right)
                  state <= WALK_RIGHT;
               else if (ground == 0)
                  state <= FALL;
            WALK_RIGHT:
               if (bump_left)
                  state <= WALK_LEFT;
               else if (ground == 0)
                  state <= FALL;
            FALL:
               if (ground == 1 && prev_ground == 0)
                  state <= (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
         endcase
      end
   end

   assign walk_left = (state == WALK_LEFT);
   assign walk_right = (state == WALK_RIGHT);
   assign aaah = (state == FALL);

   always @(posedge clk) begin
      prev_ground <= ground;
   end

endmodule
