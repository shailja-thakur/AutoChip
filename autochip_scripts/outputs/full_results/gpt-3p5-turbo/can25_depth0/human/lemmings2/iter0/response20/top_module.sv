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

   // Define the states
   reg [1:0] state;
   parameter [1:0] WALK_LEFT = 2'b00;
   parameter [1:0] WALK_RIGHT = 2'b01;
   parameter [1:0] FALL = 2'b10;

   // Outputs
   assign walk_left = (state == WALK_LEFT);
   assign walk_right = (state == WALK_RIGHT);
   assign aaah = (state == FALL);

   // Next state and output logic
   always @(posedge clk or posedge areset) begin
      if (areset) begin
         state <= WALK_LEFT;
      end
      else begin
         case (state)
            WALK_LEFT: begin
               if (bump_right && !bump_left) begin
                  state <= WALK_RIGHT;
               end
               else if (ground == 0) begin
                  state <= FALL;
               end
            end

            WALK_RIGHT: begin
               if (bump_left && !bump_right) begin
                  state <= WALK_LEFT;
               end
               else if (ground == 0) begin
                  state <= FALL;
               end
            end

            FALL: begin
               if (ground == 1) begin
                  if (state == WALK_LEFT) begin
                     state <= WALK_LEFT;
                  end
                  else if (state == WALK_RIGHT) begin
                     state <= WALK_RIGHT;
                  end
               end
            end
         endcase
      end
   end
endmodule
