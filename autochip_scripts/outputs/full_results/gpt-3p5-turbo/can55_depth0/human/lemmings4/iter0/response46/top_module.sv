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

   reg [4:0] state;
   reg walk_left;
   reg walk_right;
   reg aaah;
   reg digging;
   reg [4:0] counter;

   // State definitions
   parameter [4:0] WALK_LEFT = 4'b00001;
   parameter [4:0] WALK_RIGHT = 4'b00010;
   parameter [4:0] FALL = 4'b00100;
   parameter [4:0] DIG = 4'b01000;
   parameter [4:0] SPLATTER = 4'b10000;

   // Reset state
   always @(posedge clk or posedge areset) begin
      if (areset) begin
         state <= WALK_LEFT;
         counter <= 0;
         walk_left <= 1;
         walk_right <= 0;
         aaah <= 0;
         digging <= 0;
      end else begin
         case(state)
            WALK_LEFT: begin
               if (bump_right) begin
                  state <= WALK_RIGHT;
                  walk_left <= 0;
                  walk_right <= 1;
               end else if (bump_left && !bump_right) begin
                  state <= WALK_LEFT;
                  walk_left <= 1;
                  walk_right <= 0;
               end else if (!bump_left && !bump_right && !ground) begin
                  state <= FALL;
                  walk_left <= 0;
                  walk_right <= 0;
                  aaah <= 1;
               end else if (dig && ground) begin
                  state <= DIG;
                  walk_left <= 0;
                  walk_right <= 0;
                  digging <= 1;
               end
            end

            WALK_RIGHT: begin
               if (bump_left) begin
                  state <= WALK_LEFT;
                  walk_left <= 1;
                  walk_right <= 0;
               end else if (bump_right && !bump_left) begin
                  state <= WALK_RIGHT;
                  walk_left <= 0;
                  walk_right <= 1;
               end else if (!bump_left && !bump_right && !ground) begin
                  state <= FALL;
                  walk_left <= 0;
                  walk_right <= 0;
                  aaah <= 1;
               end else if (dig && ground) begin
                  state <= DIG;
                  walk_left <= 0;
                  walk_right <= 0;
                  digging <= 1;
               end
            end

            FALL: begin
               if (ground) begin
                  state <= state;
                  walk_left <= 1;
                  walk_right <= 1;
                  aaah <= 0;
               end else if (counter >= 20) begin
                  state <= SPLATTER;
                  walk_left <= 0;
                  walk_right <= 0;
                  aaah <= 0;
                  digging <= 0;
               end else begin
                  state <= FALL;
                  walk_left <= 0;
                  walk_right <= 0;
                  aaah <= 1;
                  counter <= counter + 1;
               end
            end

            DIG: begin
               if (!ground) begin
                  state <= FALL;
                  walk_left <= 0;
                  walk_right <= 0;
                  aaah <= 1;
                  digging <= 0;
               end else begin
                  state <= DIG;
                  walk_left <= 0;
                  walk_right <= 0;
                  digging <= 1;
               end
            end

            SPLATTER: begin
               state <= SPLATTER;
               walk_left <= 0;
               walk_right <= 0;
               aaah <= 0;
               digging <= 0;
            end
         endcase
      end
   end

endmodule
