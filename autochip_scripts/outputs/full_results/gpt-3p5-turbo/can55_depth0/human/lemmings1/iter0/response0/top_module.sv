module top_module (
   input clk,
   input areset,
   input bump_left,
   input bump_right,
   output reg walk_left,
   output reg walk_right
);

reg [1:0] state;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;

always @(posedge clk or posedge areset) begin
   if (areset) begin
      state <= WALK_LEFT;
      walk_left <= 1;
      walk_right <= 0;
   end else begin
      case (state)
         WALK_LEFT: begin
            if (bump_left && !bump_right) begin
               state <= WALK_RIGHT;
               walk_left <= 0;
               walk_right <= 1;
            end else if (!bump_left && bump_right) begin
               state <= WALK_LEFT;
               walk_left <= 1;
               walk_right <= 0;
            end else if (bump_left && bump_right) begin
               state <= WALK_RIGHT;
               walk_left <= 0;
               walk_right <= 1;
            end else begin
               state <= WALK_LEFT;
               walk_left <= 1;
               walk_right <= 0;
            end
         end
         WALK_RIGHT: begin
            if (!bump_left && bump_right) begin
               state <= WALK_LEFT;
               walk_left <= 1;
               walk_right <= 0;
            end else if (bump_left && !bump_right) begin
               state <= WALK_RIGHT;
               walk_left <= 0;
               walk_right <= 1;
            end else if (bump_left && bump_right) begin
               state <= WALK_LEFT;
               walk_left <= 1;
               walk_right <= 0;
            end else begin
               state <= WALK_RIGHT;
               walk_left <= 0;
               walk_right <= 1;
            end
         end
      endcase
   end
end

endmodule
