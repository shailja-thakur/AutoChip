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

  // Define the states
  parameter WALK_LEFT = 2'b00;
  parameter WALK_RIGHT = 2'b01;
  parameter DIG = 2'b10;
  parameter FALL = 2'b11;

  // Define the signals
  reg [1:0] state;
  reg [1:0] next_state;
  reg walk_left;
  reg walk_right;
  reg aaah;
  reg digging;

  // Synchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
    end else begin
      state <= next_state;
    end
  end

  // Combinational logic
  always @(*) begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    if (state == WALK_LEFT) begin
      if (bump_right == 1) begin
        next_state = WALK_RIGHT;
        walk_right = 1;
      end else if (ground == 0) begin
        next_state = FALL;
        aaah = 1;
      end else if (dig == 1 && ground == 1) begin
        next_state = DIG;
        digging = 1;
      end
    end else if (state == WALK_RIGHT) begin
      if (bump_left == 1) begin
        next_state = WALK_LEFT;
        walk_left = 1;
      end else if (ground == 0) begin
        next_state = FALL;
        aaah = 1;
      end else if (dig == 1 && ground == 1) begin
        next_state = DIG;
        digging = 1;
      end
    end else if (state == DIG) begin
      if (ground == 0) begin
        next_state = FALL;
        aaah = 1;
      end
    end else if (state == FALL) begin
      if (ground == 1) begin
        if (bump_right == 1) begin
          next_state = WALK_RIGHT;
          walk_right = 1;
        end else if (bump_left == 1) begin
          next_state = WALK_LEFT;
          walk_left = 1;
        end else begin
          next_state = state;
        end
      end
    end
  end

endmodule
