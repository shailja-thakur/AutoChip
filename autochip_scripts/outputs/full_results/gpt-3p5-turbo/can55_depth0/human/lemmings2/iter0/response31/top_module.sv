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

   reg [1:0] state, next_state;

   parameter WALK_LEFT = 2'b00;
   parameter WALK_RIGHT = 2'b01;
   parameter FALL = 2'b10;

   always @(posedge clk or posedge areset) begin
      if (areset) begin
         state <= WALK_LEFT;
      end else begin
         state <= next_state;
      end
   end

   always @* begin
      next_state = state;
      walk_left = 1'b0;
      walk_right = 1'b0;
      aaah = 1'b0;

      case(state)
         WALK_LEFT: begin
            if (bump_right) begin
               next_state = WALK_RIGHT;
            end else if (!ground) begin
               next_state = FALL;
            end else begin
               walk_left = 1'b1;
            end
         end

         WALK_RIGHT: begin
            if (bump_left) begin
               next_state = WALK_LEFT;
            end else if (!ground) begin
               next_state = FALL;
            end else begin
               walk_right = 1'b1;
            end
         end

         FALL: begin
            if (ground) begin
               if (state == WALK_LEFT) begin
                  walk_left = 1'b1;
               end else begin
                  walk_right = 1'b1;
               end
            end else begin
               aaah = 1'b1;
            end
         end
      endcase
   end

endmodule
