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
                  end else begin
                     if (dig && ground && !fall) begin
                        state <= 2;
                     end else begin
                        if (bump_left && (fall == 0)) begin
                           state <= 4;
                        end else begin
                           if (bump_right && (fall == 0)) begin
                              state <= 5;
                           end else begin
                              if (bump_left && bump_right && (fall == 0)) begin
                                 state <= 3;
                              end else begin
                                 if ((ground == 0) && (fall == 1)) begin
                                    state <= 6;
                                 end else begin
                                    state <= 0;
                                 end
                              end
                           end
                        end
                     end
                  end
               end
            1: begin
                  if ((!fall) && (ground == 0)) begin
                     state <= 6;
                  end else if ((fall == 0) && (ground == 1)) begin
                     state <= 0;
                  end else begin
                     state <= state;
                  end
               end
            2: begin
                  if ((ground == 0)) begin
                     state <= 6;
                  end else begin
                     state <= state;
                  end
               end
            3: begin
                  if ((ground == 0)) begin
                     state <= 6;
                  end else begin
                     state <= state;
                  end
               end
            4: begin
                  if ((fall == 1) && (ground == 0)) begin
                     state <= 6;
                  end else begin
                     state <= state;
                  end
               end
            5: begin
                  if ((fall == 1) && (ground == 0)) begin
                     state <= 6;
                  end else begin
                     state <= state;
                  end
               end
            6: begin
                  if ((!fall) && (ground == 1)) begin
                     state <= 0;
                  end else if ((fall == 1) && (ground == 0)) begin
                     state <= 6;
                  end else begin
                     state <= state;
                  end
               end
            default: state <= 0;
         endcase
      end
   end

   always @(posedge clk) begin
      if ((fall && (ground == 0))) begin
         fall_count <= fall_count + 1;
      end else begin
         fall_count <= 0;
      end
   end

   always @(state or fall_count or fall or ground) begin
      case (state)
         0: begin
            walk_lr <= 1;
            splatter <= 0;
            fall <= 0;
         end
         1: begin
            walk_lr <= walk_lr;
            splatter <= 0;
            fall <= 0;
         end
         2: begin
            walk_lr <= walk_lr;
            splatter <= 0;
            fall <= 0;
         end
         3: begin
            walk_lr <= !walk_lr;
            splatter <= 0;
            fall <= 0;
         end
         4: begin
            walk_lr <= 1;
            splatter <= 0;
            fall <= 0;
         end
         5: begin
            walk_lr <= 0;
            splatter <= 0;
            fall <= 0;
         end
         6: begin
            walk_lr <= walk_lr;
            splatter <= (fall_count > 20);
            fall <= 1;
         end
         default: begin
            walk_lr <= 0;
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
      end else if (state == 4 || state == 5) begin
         walk_left <= walk_lr;
         walk_right <= ~walk_lr;
         aaah <= 0;
         digging <= 0;
      end else if (state == 6) begin
         walk_left <= walk_lr;
         walk_right <= ~walk_lr;
         aaah <= splatter && !fall && ground;
         digging <= 0;
      end
   end
endmodule
