module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);
 
reg [1:0] state;
 
parameter [1:0] WALK_LEFT = 2'b01;
parameter [1:0] WALK_RIGHT = 2'b10;
parameter [1:0] FALL = 2'b11;
parameter [1:0] DIG = 2'b00;
 
always @(posedge clk or posedge areset)
if (areset)
   state <= WALK_LEFT;
else
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
         if (state == WALK_LEFT)
            state <= WALK_LEFT;
         else if (state == WALK_RIGHT)
            state <= WALK_RIGHT;
         else if (state == DIG)
            state <= FALL;
      end
      
   DIG:
      if (!ground) begin
         state <= FALL;
      end else if (!dig) begin
         if (state == WALK_LEFT)
            state <= WALK_LEFT;
         else if (state == WALK_RIGHT)
            state <= WALK_RIGHT;
         else if (state == FALL)
            state <= FALL;
      end
      
   endcase
 
always @(state)
begin
   case (state)
     
   WALK_LEFT:
      walk_left = 1;
      walk_right = 0;
      aaah = 0;
      digging = 0;
      
   WALK_RIGHT:
      walk_left = 0;
      walk_right = 1;
      aaah = 0;
      digging = 0;
     
   FALL:
      walk_left = 0;
      walk_right = 0;
      aaah = 1;
      digging = 0;
      
   DIG:
      walk_left = 0;
      walk_right = 0;
      aaah = 0;
      digging = 1;
     
   endcase
end
 
endmodule
