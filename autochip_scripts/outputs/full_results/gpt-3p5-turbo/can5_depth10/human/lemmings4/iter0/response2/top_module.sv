module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

   reg [4:0] state;

   always @(posedge clk or posedge areset) begin
      if (areset)
         state <= 0;
      else begin
         case(state)
            0: begin
                  walk_left <= 1;
                  walk_right <= 0;
                  aaah <= 0;
                  digging <= 0;
                  if (bump_right)
                     state <= 1;
                  else if (bump_left)
                     state <= 2;
                  else if (!ground)
                     state <= 3;
               end
            1: begin
                  walk_left <= 1;
                  walk_right <= 0;
                  aaah <= 0;
                  digging <= 0;
                  if (bump_left)
                     state <= 2;
                  else if (!ground)
                     state <= 3;
               end
            2: begin
                  walk_left <= 0;
                  walk_right <= 1;
                  aaah <= 0;
                  digging <= 0;
                  if (bump_right)
                     state <= 1;
                  else if (!ground)
                     state <= 3;
               end
            3: begin
                  walk_left <= 0;
                  walk_right <= 1;
                  aaah <= 1;
                  digging <= 0;
                  if (ground)
                     state <= 0;
               end
            4: begin
                  walk_left <= 0;
                  walk_right <= 0;
                  aaah <= 0;
                  digging <= 1;
                  if (!ground)
                     state <= 4;
                  else
                     state <= 0;
               end
         endcase
      end
   end
endmodule
