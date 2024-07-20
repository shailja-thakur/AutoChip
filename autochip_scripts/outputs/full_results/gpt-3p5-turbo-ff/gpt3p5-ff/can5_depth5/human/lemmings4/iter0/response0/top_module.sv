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
   reg [4:0] next_state;
  
   localparam [4:0] WALK_LEFT = 5'b00001;
   localparam [4:0] WALK_RIGHT = 5'b00010;
   localparam [4:0] FALL = 5'b00011;
   localparam [4:0] DIG = 5'b00100;
   localparam [4:0] SPLATTER = 5'b00101;
  
   always @(posedge clk or posedge areset) begin
      if (areset) begin
         state <= WALK_LEFT;
         walk_left <= 1'b1;
         walk_right <= 1'b0;
         aaah <= 1'b0;
         digging <= 1'b0;
      end else begin
         state <= next_state;
      end
   end
  
   always @(state or bump_left or bump_right or ground or dig) begin
      aaah <= 1'b0;
      dig <= 1'b0;
      walk_left <= 1'b0;
      walk_right <= 1'b0;
      digging <= 1'b0;
      
      case(state)
         WALK_LEFT: begin
            if (bump_right & !bump_left) begin
               next_state <= WALK_RIGHT;
               walk_right <= 1'b1;
            end else if (bump_right & bump_left) begin
               next_state <= WALK_RIGHT;
               walk_right <= 1'b1;
            end else if (!ground) begin
               next_state <= FALL;
               aaah <= 1'b1;
            end else if (dig) begin
               next_state <= DIG;
               digging <= 1'b1;
            end else begin
               next_state <= WALK_LEFT;
               walk_left <= 1'b1;
            end
         end
         WALK_RIGHT: begin
            if (bump_left & !bump_right) begin
               next_state <= WALK_LEFT;
               walk_left <= 1'b1;
            end else if (bump_left & bump_right) begin
               next_state <= WALK_LEFT;
               walk_left <= 1'b1;
            end else if (!ground) begin
               next_state <= FALL;
               aaah <= 1'b1;
            end else if (dig) begin
               next_state <= DIG;
               digging <= 1'b1;
            end else begin
               next_state <= WALK_RIGHT;
               walk_right <= 1'b1;
            end
         end
         FALL: begin
            if (ground) begin
               next_state <= WALK_LEFT;
               walk_left <= 1'b1;
            end else if (dig) begin
               next_state <= DIG;
               digging <= 1'b1;
            end else if (state == FALL && next_state == FALL) begin
               if (aaah == 0) begin
                  if (count > 20) begin
                     next_state <= SPLATTER;
                     walk_left <= 1'b0;
                     walk_right <= 1'b0;
                     aaah <= 1'b0;
                     digging <= 1'b0;
                  end else begin
                     count <= count + 1;
                  end
               end
            end else begin
               next_state <= FALL;
               aaah <= 1'b1;
            end
         end
         DIG: begin
            if (!ground) begin
               next_state <= FALL;
               aaah <= 1'b1;
            end else begin
               next_state <= DIG;
               digging <= 1'b1;
            end
         end
         SPLATTER: begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
            next_state <= SPLATTER;
         end
      endcase
   end

endmodule
