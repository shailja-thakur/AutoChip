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
   reg splatter;
   reg walk_lr;
   reg fall;
   reg fall_count;

   always @(posedge clk or posedge areset) begin
      if (areset) begin
         state <= 0;
         walk_lr <= 1;
         splatter <= 0;
         fall <= 0;
         fall_count <= 0;
      end else begin
         case (state)
            0: begin
                  if (fall && ground) begin
                     state <= 1;
                  end else if (dig && ground && !fall) begin
                     state <= 2;
                  end else if (bump_right && !fall) begin
                     state <= 3;
                  end else if (bump_left && !fall) begin
                     state <= 4;
                  end else if (fall && !ground) begin
                     state <= 6;
                  end else begin
                     state <= 0;
                  end
               end
            1: begin
                  if (!fall && ground) begin
                     state <= 0;
                  end else if (!fall && !ground) begin
                     state <= 6;
                  end else begin
                     state <= 1;
                  end
               end
            2: begin
                  if (fall || !ground) begin
                     state <= 6;
                  end else begin
                     state <= 2;
                  end
               end
            3: begin
                  if (fall || !ground) begin
                     state <= 6;
                  end else begin
                     state <= 3;
                  end
               end
            4: begin
                  if (fall || !ground) begin
                     state <= 6;
                  end else begin
                     state <= 4;
                  end
               end
            6: begin
                  if (!fall && ground) begin
                     state <= 1;
                  end else if (fall || !ground) begin
                     state <= 6;
                  end else begin
                     state <= 6;
                  end
               end
            default: state <= 0;
         endcase
      end
   end

   always @(posedge clk) begin
      if (fall && !ground) begin
         fall_count <= fall_count + 1;
      end else begin
         fall_count <= 0;
      end
   end

   always @(state or fall_count) begin
      case (state)
         0: begin
            walk_lr <= 1;
            splatter <= 0;
            fall <= 0;
         end
         1, 2: begin
            walk_lr <= walk_lr;
            splatter <= 0;
            fall <= 0;
         end
         3: begin
            walk_lr <= ~walk_lr;
            splatter <= 0;
            fall <= 0;
         end
         4: begin
            walk_lr <= 1;
            splatter <= 0;
            fall <= 0;
         end
         6: begin
            walk_lr <= walk_lr;
            splatter <= (fall_count > 20);
            fall <= 1;
         end
         default: begin
            walk_lr <= 1;
            splatter <= 0;
            fall <= 0;
         end
      endcase

      if (state == 0) begin
         walk_left <= walk_lr;
         walk_right <= ~walk_lr;
         aaah <= 0;
         digging <= 0;
      end else if (state == 1 || state == 2) begin
         walk_left <= walk_lr;
         walk_right <= ~walk_lr;
         aaah <= 0;
         digging <= (state == 2) ? dig : 0;
      end else if (state == 3) begin
         walk_left <= ~walk_lr;
         walk_right <= walk_lr;
         aaah <= 0;
         digging <= 0;
      end else if (state == 4) begin
         walk_left <= walk_lr;
         walk_right <= ~walk_lr;
         aaah <= 0;
         digging <= 0;
      end else if (state == 6) begin
         walk_left <= walk_lr;
         walk_right <= ~walk_lr;
         aaah <= (fall && ground && (fall_count > 20));
         digging <= 0;
      end
   end
endmodule
