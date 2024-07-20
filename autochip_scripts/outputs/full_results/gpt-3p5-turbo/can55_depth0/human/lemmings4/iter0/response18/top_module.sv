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
  
  parameter WALK_LEFT = 3'b000;
  parameter WALK_RIGHT = 3'b001;
  parameter FALL = 3'b010;
  parameter DIG = 3'b011;
  parameter SPLATTER = 3'b100;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
      walk_left <= 1'b1;
      walk_right <= 1'b0;
      aaah <= 1'b0;
      digging <= 1'b0;
      counter <= 5'd0;
    end else begin
      case(state)
        WALK_LEFT:
          if (bump_right) begin
              state <= DIG;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              aaah <= 1'b0;
              digging <= 1'b1;
          end else if (!ground) begin
              state <= FALL;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              aaah <= 1'b1;
              digging <= 1'b0;
          end else begin
              walk_left <= 1'b1;
              walk_right <= 1'b0;
              aaah <= 1'b0;
              digging <= 1'b0;
          end
          
        WALK_RIGHT:
          if (bump_left) begin
              state <= DIG;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              aaah <= 1'b0;
              digging <= 1'b1;
          end else if (!ground) begin
              state <= FALL;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              aaah <= 1'b1;
              digging <= 1'b0;
          end else begin
              walk_left <= 1'b0;
              walk_right <= 1'b1;
              aaah <= 1'b0;
              digging <= 1'b0;
          end
          
        DIG:
          if (!ground || !dig) begin
              state <= FALL;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              aaah <= 1'b1;
              digging <= 1'b0;
          end else if (!bump_left && !bump_right) begin
              walk_left <= walk_left;
              walk_right <= walk_right;
              aaah <= 1'b0;
              digging <= 1'b1;
          end
          
        FALL:
          if (ground) begin
              state <= walk_left ? WALK_LEFT : WALK_RIGHT;
              walk_left <= walk_left;
              walk_right <= walk_right;
              aaah <= 1'b0;
              digging <= 1'b0;
          end else if (counter == 5'd20) begin
              state <= SPLATTER;
              walk_left <= 1'b0;
              walk_right <= 1'b0;
              aaah <= 1'b0;
              digging <= 1'b0;
          else begin
              counter <= counter + 1;
              walk_left <= walk_left;
              walk_right <= walk_right;
              aaah <= 1'b1;
              digging <= 1'b0;
          end
          
        SPLATTER:
          walk_left <= 1'b0;
          walk_right <= 1'b0;
          aaah <= 1'b0;
          digging <= 1'b0;
      endcase
    end
  end
  
endmodule
