module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
   reg walk_state;
   reg next_state;
   reg walk_output;

   always @(posedge clk or posedge areset) begin
      if (areset) begin
         walk_state <= 1'b0;
      end else begin
         walk_state <= next_state;
      end
   end

   always @(walk_state or bump_left or bump_right) begin
      case (walk_state)
         1'b0: begin
            if (bump_left && bump_right) begin
               next_state = 1'b1;
            end else if (bump_left) begin
               next_state = 1'b1;
            end else if (bump_right) begin
               next_state = 1'b0;
            end else begin
               next_state = 1'b0;
            end
            walk_output = 1'b1;
         end

         1'b1: begin
            if (bump_left && bump_right) begin
               next_state = 1'b0;
            end else if (bump_left) begin
               next_state = 1'b1;
            end else if (bump_right) begin
               next_state = 1'b0;
            end else begin
               next_state = 1'b1;
            end
            walk_output = 1'b0;
         end

         default: begin
            next_state = 1'b0;
            walk_output = 1'b0;
         end
      endcase
   end

   assign walk_left = walk_output;
   assign walk_right = ~walk_output;

endmodule
