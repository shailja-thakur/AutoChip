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

  reg walking;
  reg digging;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      walking <= 0;
      digging <= 0;
    end else if (fall_counter >= 20 || next_state == SPLATTER) begin
      walking <= 0;
      digging <= 0;
    end else if (current_state == WALK_LEFT && bump_right) begin
      walking <= 1;
      digging <= 0;
      walk_left <= 0;
      walk_right <= 1;
    end else if (current_state == WALK_RIGHT && bump_left) begin
      walking <= 1;
      digging <= 0;
      walk_left <= 1;
      walk_right <= 0;
    end else if (current_state == FALL) begin
      walking <= 1;
      digging <= 0;
      walk_left <= walking && !digging;
      walk_right <= walking && !digging;
    end else if (current_state == DIG && !dig) begin
      walking <= 1;
      digging <= 0;
      walk_left <= walking && !digging;
      walk_right <= walking && !digging;
    end else if (current_state == DIG && fall_counter >= 20) begin
      walking <= 0;
      digging <= 0;
    end else if (current_state == FALL && ground) begin
      walking <= 1;
      digging <= 0;
      walk_left <= walking && !digging;
      walk_right <= walking && !digging;
    end else begin
      walking <= 1;
      digging <= dig && ground && current_state != DIG;
      walk_left <= walking && !digging;
      walk_right <= walking && !digging;
    end
  end

  always @(*) begin
    if (areset) begin
      next_state = WALK_LEFT;
      fall_counter = 0;
    end else if (fall_counter >= 20) begin
      next_state = SPLATTER;
    end else if (current_state == WALK_LEFT && bump_right) begin
      next_state = WALK_RIGHT;
    end else if (current_state == WALK_RIGHT && bump_left) begin
      next_state = WALK_LEFT;
    end else if (current_state == WALK_LEFT && dig && ground) begin
      next_state = DIG;
    end else if (!ground && !bump_left && current_state != DIG) begin
      next_state = FALL;
    end else if (current_state == WALK_RIGHT && dig && ground) begin
      next_state = DIG;
    end else if (!ground && !bump_right && current_state != DIG) begin
      next_state = FALL;
    end else if (ground) begin
      next_state = last_state;
      fall_counter = 0;
    end else begin
      next_state = current_state;
      fall_counter = fall_counter + 1;
    end
  end

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
      fall_counter <= 0;
      last_state <= WALK_LEFT;
      aaah <= 0;
    end else begin
      current_state <= next_state;
      fall_counter <= fall_counter;
      last_state <= current_state;
      aaah <= aaah;
    end
  end

endmodule
