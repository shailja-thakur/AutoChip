module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
   
   // Parameter declaration
   parameter WL = 1'b0;
   parameter WR = 1'b1;
   
   // State declaration
   reg state, next_state;
   always @(posedge clk or posedge areset) begin
      if (areset)
         state <= WL;
      else
         state <= next_state;
   end
   
   // Next state logic
   always @(state, bump_left, bump_right) begin
      case (state)
         WL: begin
            if (bump_left)
               next_state = WR;
            else
               next_state = WL;
         end
         WR: begin
            if (bump_right)
               next_state = WL;
            else
               next_state = WR;
         end
      endcase
   end
   
   // Output assignment
   assign walk_left = (state == WL) ? 1'b1 : 1'b0;
   assign walk_right = (state == WR) ? 1'b1 : 1'b0;
   
endmodule
