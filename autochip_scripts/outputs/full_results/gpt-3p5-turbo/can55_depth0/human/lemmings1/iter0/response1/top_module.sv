module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
   reg [1:0] current_state;
   reg walk_left;
   reg walk_right;

   parameter LEFT = 2'b00;
   parameter RIGHT = 2'b01;

   always @(posedge clk or posedge areset) begin
      if (areset) begin
         current_state <= LEFT;
      end else begin
         case (current_state)
            LEFT: begin
               if (bump_left || (bump_left && bump_right)) begin
                  current_state <= RIGHT;
               end
            end
            RIGHT: begin
               if (bump_right || (bump_left && bump_right)) begin
                  current_state <= LEFT;
               end
            end
         endcase
      end
   end

   always @(current_state) begin
      case (current_state)
         LEFT: begin
            walk_left <= 1;
            walk_right <= 0;
         end
         RIGHT: begin
            walk_left <= 0;
            walk_right <= 1;
         end
      endcase
   end
endmodule
