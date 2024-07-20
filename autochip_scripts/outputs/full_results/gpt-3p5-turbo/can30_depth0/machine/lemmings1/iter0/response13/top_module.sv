module top_module (
   input clk,
   input areset,
   input bump_left,
   input bump_right,
   output walk_left,
   output walk_right
);
   
   // Define the state parameters
   parameter WL = 1'b0;
   parameter WR = 1'b1;
   
   // Define the state register
   reg state;
   
   // Assign the walking directions based on the state
   always @ (posedge clk or posedge areset)
      if (areset)
         state <= WL;
      else if (state == WL)
         if (bump_left)
            state <= WR;
         else
            state <= WL;
      else if (state == WR)
         if (bump_right)
            state <= WL;
         else
            state <= WR;
   
   // Assign the output walking directions based on the state
   assign walk_left = (state == WL) ? 1'b1 : 1'b0;
   assign walk_right = (state == WR) ? 1'b1 : 1'b0;
   
endmodule
