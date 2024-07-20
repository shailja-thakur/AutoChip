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
   reg [4:0] nextState;

   parameter WALK_LEFT = 3'b000;
   parameter WALK_RIGHT = 3'b001;
   parameter FALL = 3'b010;
   parameter DIG = 3'b011;
   parameter SPLATTER = 3'b100;

   reg [4:0] counter;

   always @(posedge clk or posedge areset) begin
      if (areset)
         state <= WALK_LEFT;
      else
         state <= nextState;
   end

   always @(state or bump_left or bump_right or ground or dig) begin
      case(state)
         WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;

            if (bump_right)
               nextState = WALK_RIGHT;
            else if (ground == 0)
               nextState = FALL;
            else if (dig)
               nextState = DIG;
            else
               nextState = WALK_LEFT;
         end

         WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;

            if (bump_left)
               nextState = WALK_LEFT;
            else if (ground == 0)
               nextState = FALL;
            else if (dig)
               nextState = DIG;
            else
               nextState = WALK_RIGHT;
         end

         FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;

            if (ground)
               nextState = nextState[2:0];
            else
               nextState = FALL;
         end

         DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;

            if (ground)
               nextState = nextState[2:0];
            else
               nextState = FALL;
         end

         SPLATTER: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
         end
      endcase
   end

   always @(posedge clk) begin
      if (state == FALL)
         counter <= counter + 1;
      else if (ground)
         counter <= 0;
   end

   always @(counter or ground) begin
      if (counter >= 20)
         nextState = SPLATTER;
   end

endmodule
