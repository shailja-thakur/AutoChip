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

  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= 1;
    else
      case (state)
        1: begin
             if (bump_left & !bump_right)
               state <= 2;
             else if (!bump_left & bump_right)
               state <= 3;
             else if (bump_left & bump_right)
               state <= 4;
             else if (dig)
               state <= 5;
             else if (!ground)
               state <= 6;
           end
        2: state <= 3;
        3: state <= 2;
        4: state <= 2;
        5: state <= 6;
        6: begin
             if (ground)
               state <= 1;
             else if (aaah)
               state <= 7;
           end
        default: state <= 1;
      endcase
  end

  always @(state)
  begin
    case (state)
      1: begin
           walk_left <= 1;
           walk_right <= 0;
           aaah <= 0;
           digging <= 0;
         end
      2: begin
           walk_left <= 0;
           walk_right <= 1;
           aaah <= 0;
           digging <= 0;
         end
      3: begin
           walk_left <= 1;
           walk_right <= 0;
           aaah <= 0;
           digging <= 0;
         end
      4: begin
           walk_left <= 0;
           walk_right <= 1;
           aaah <= 0;
           digging <= 0;
         end
      5: begin
           walk_left <= 0;
           walk_right <= 0;
           aaah <= 0;
           digging <= 1;
         end
      6: begin
           walk_left <= 0;
           walk_right <= 0;
           aaah <= 1;
           digging <= 0;
         end
      default: begin
                 walk_left <= 1;
                 walk_right <= 0;
                 aaah <= 0;
                 digging <= 0;
               end
    endcase
  end

endmodule
