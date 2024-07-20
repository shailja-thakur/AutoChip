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
  reg [4:0] next_state;
  reg [4:0] count;

  parameter WALK_LEFT = 5'b00001;
  parameter WALK_RIGHT = 5'b00010;
  parameter FALLING = 5'b00100;
  parameter DIGGING = 5'b01000;
  parameter SPLATTER = 5'b10000;

  always @(posedge clk, posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
      count <= 0;
    end else begin
      state <= next_state;
      count <= count + 1;
    end
  end

  always @* begin
    next_state = state;
    walk_left = (state == WALK_LEFT);
    walk_right = (state == WALK_RIGHT);
    aaah = (state == FALLING);
    digging = (state == DIGGING);

    case (state)
      WALK_LEFT: begin
        if (bump_right)
          next_state = WALK_RIGHT;
        else if (ground == 0)
          next_state = FALLING;
        else if (dig && ground)
          next_state = DIGGING;
      end

      WALK_RIGHT: begin
        if (bump_left)
          next_state = WALK_LEFT;
        else if (ground == 0)
          next_state = FALLING;
        else if (dig && ground)
          next_state = DIGGING;
      end

      FALLING: begin
        if (ground) begin
          if (count >= 20)
            next_state = SPLATTER;
          else
            next_state = state;
        end
      end

      DIGGING: begin
        if (!ground)
          next_state = FALLING;
      end

      SPLATTER: begin
        next_state = SPLATTER;
      end
    endcase
  end

endmodule
