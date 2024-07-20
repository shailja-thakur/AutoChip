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

  reg delay_reset;

  wire falling;
  wire splatter;
  wire ready_to_fall;
  wire ready_to_dig;

  assign delay_reset = #(1, 0) areset;

  assign ready_to_fall = (state == 5'b00010 && ground);
  assign ready_to_dig = (state == 5'b00100 && ~falling);

  always @(posedge clk or posedge delay_reset)
  begin
    if (delay_reset)
    begin
      state <= 5'b10000;
    end
    else
    begin
      state <= next_state;
    end
  end

  always @*
  begin
    case (state)
      5'b10000: // walking left state
      begin
        if (bump_right && ~falling)
        begin
          next_state = 5'b01000;
        end
        else if (ready_to_dig && dig)
        begin
          next_state = 5'b00100;
        end
        else if (!ground)
        begin
          next_state = 5'b00010;
        end
        else
        begin
          next_state = 5'b10000;
        end
      end
      5'b01000: // walking right state
      begin
        if (bump_left && ~falling)
        begin
          next_state = 5'b10000;
        end
        else if (ready_to_dig && dig)
        begin
          next_state = 5'b00100;
        end
        else if (!ground)
        begin
          next_state = 5'b00010;
        end
        else
        begin
          next_state = 5'b01000;
        end
      end
      5'b00100: // digging state
      begin
        if (!ground || (bump_left && ~falling) || (bump_right && ~falling))
        begin
          next_state = 5'b00010;
        end
        else
        begin
          next_state = 5'b00100;
        end
      end
      5'b00010: // falling state
      begin
        if (ground)
        begin
          if (falling && splatter)
          begin
            next_state = 5'b00001;
          end
          else
          begin
            next_state = 5'b10000;
          end
        end
        else if (falling && !ready_to_fall)
        begin
          next_state = state;
        end
        else
        begin
          next_state = state - 1;
        end
      end
      5'b00001: // splatter state
      begin
        next_state = 5'b00001;
      end
    endcase
  end

  always @(state)
  begin
    case (state)
      5'b10000: // walking left state
      begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end
      5'b01000: // walking right state
      begin
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
        digging = 0;
      end
      5'b00100: // digging state
      begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 1;
      end
      5'b00010: // falling state
      begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end
      5'b00001: // splatter state
      begin
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
        digging = 0;
      end
    endcase
  end

  always @(posedge clk)
  begin
    if (areset)
    begin
      falling <= 0;
      splatter <= 0;
    end
    else
    begin
      falling <= (state == 5'b00010);
      splatter <= (ready_to_fall && ground);
    end
  end

endmodule
