module top_module (
   input clk,
   input areset,
   input bump_left,
   input bump_right,
   output walk_left,
   output walk_right
);


   parameter WL = 0; // Represents the state WL
   parameter WR = 1; // Represents the state WR
   
   reg state; // Register to hold the current state
   
   always @(posedge clk or posedge areset) begin
      if (areset) begin
         state <= WL; // Reset the state machine to WL
      end else begin
         if (state == WL) begin // If the current state is WL
            if (bump_left) begin // If bump_left is high, transition to WR
               state <= WR;
            end else begin // If bump_left is low, stay in WL
               state <= WL;
            end
         end else begin // If the current state is WR
            if (bump_right) begin // If bump_right is high, transition to WL
               state <= WL;
            end else begin // If bump_right is low, stay in WR
               state <= WR;
            end
         end
      end
   end
   
   assign walk_left = (state == WL) ? 1'b1 : 1'b0; // Set walk_left based on the current state
   assign walk_right = (state == WR) ? 1'b1 : 1'b0; // Set walk_right based on the current state


endmodule
