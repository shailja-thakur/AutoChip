module top_module (
   input clk,
   input areset,
   input bump_left,
   input bump_right,
   input ground,
   input dig,
   output walk_left,
   output walk_right,
   output aaah,
   output digging
);
   reg [1:0] state;

   always @(posedge clk or posedge areset) begin
      if (areset)
         state <= 2'b10;
      else begin
         case(state)
            2'b00: begin // walking left
               if (bump_right && !bump_left)
                  state <= 2'b01; // walking right
               else if (bump_left && !bump_right)
                  state <= 2'b00; // walking left
               else if (bump_left && bump_right)
                  state <= 2'b01; // walking right
               else if (!ground)
                  state <= 2'b10; // falling
               else if (dig)
                  state <= 2'b11; // digging
            end

            2'b01: begin // walking right
               if (bump_left && !bump_right)
                  state <= 2'b00; // walking left
               else if (bump_right && !bump_left)
                  state <= 2'b01; // walking right
               else if (bump_left && bump_right)
                  state <= 2'b00; // walking left
               else if (!ground)
                  state <= 2'b10; // falling
               else if (dig)
                  state <= 2'b11; // digging
            end

            2'b10: begin // falling
               if (ground)
                  if(state == 2'b00)
                     state <= 2'b00; // walking left
                  else if(state == 2'b01)
                     state <= 2'b01; // walking right
            end

            2'b11: begin // digging
               if (!dig)
                  state <= 2'b00; // walking left
               else if (!ground)
                  state <= 2'b10; // falling
            end
         endcase
      end
   end
   
   assign walk_left = (state == 2'b00);
   assign walk_right = (state == 2'b01);
   assign aaah = (state == 2'b10);
   assign digging = (state == 2'b11);
   
endmodule
