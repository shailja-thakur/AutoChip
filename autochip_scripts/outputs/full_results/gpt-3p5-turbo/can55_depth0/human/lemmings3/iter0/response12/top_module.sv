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
   reg [1:0] next_state;
   
   parameter WALK_LEFT = 2'b00;
   parameter WALK_RIGHT = 2'b01;
   parameter FALL = 2'b10;
   parameter DIG = 2'b11;

   always @(posedge clk or posedge areset)
   begin
      if (areset)
         state <= WALK_LEFT;
      else
         state <= next_state;
   end

   always @*
   begin
      next_state = state;

      case (state)

         WALK_LEFT:
         begin
            if (bump_right && !bump_left)
               next_state = WALK_RIGHT;
            else if (ground == 0)
               next_state = FALL;
            else if (dig)
               next_state = DIG;
         end

         WALK_RIGHT:
         begin
            if (bump_left && !bump_right)
               next_state = WALK_LEFT;
            else if (ground == 0)
               next_state = FALL;
            else if (dig)
               next_state = DIG;
         end

         FALL:
         begin
            if (ground)
               next_state = state;
         end

         DIG:
         begin
            if (!ground)
               next_state = FALL;
         end

      endcase
   end

   assign walk_left = (state == WALK_LEFT) ? 1 : 0;
   assign walk_right = (state == WALK_RIGHT) ? 1 : 0;
   assign aaah = (state == FALL) ? 1 : 0;
   assign digging = (state == DIG) ? 1 : 0;

endmodule
