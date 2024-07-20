module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

   reg [1:0] state;
   reg walk_left;
   reg walk_right;

   // Define the states
   parameter WALK_LEFT = 2'b00;
   parameter WALK_RIGHT = 2'b01;

   // Reset the state machine to initial state on positive edge of areset
   always @(posedge areset) begin
      state <= WALK_LEFT;
      walk_left <= 1;
      walk_right <= 0;
   end

   // State transitions and output assignments
   always @(posedge clk) begin
      case (state)
         WALK_LEFT: begin
            if (bump_left == 1) begin
               state <= WALK_RIGHT;
               walk_left <= 0;
               walk_right <= 1;
            end
         end

         WALK_RIGHT: begin
            if (bump_right == 1) begin
               state <= WALK_LEFT;
               walk_left <= 1;
               walk_right <= 0;
            end
         end
      endcase
   end

endmodule
