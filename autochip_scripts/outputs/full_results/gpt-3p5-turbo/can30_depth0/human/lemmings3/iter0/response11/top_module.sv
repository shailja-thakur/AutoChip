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

  reg [1:0] state;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 0;
    end else begin
      case (state)
        0: begin // walking left
          if (bump_right && !bump_left) begin
            state <= 1; // switch to walking right
          end else if (!ground) begin
            state <= 2; // fall
          end else if (dig) begin
            state <= 3; // start digging
          end
        end
        1: begin // walking right
          if (bump_left && !bump_right) begin
            state <= 0; // switch to walking left
          end else if (!ground) begin
            state <= 2; // fall
          end else if (dig) begin
            state <= 3; // start digging
          end
        end
        2: begin // falling
          if (ground) begin
            state <= (state == 2 && walk_left) ? 0 : 1; // resume walking
          end
        end
        3: begin // digging
          if (!ground) begin
            state <= 2; // fall
          end
        end
      endcase
    end
  end

  always @(state, ground) begin
    case (state)
      0: begin // walking left
        walk_left = 1;
        walk_right = 0;
        digging = 0;
        aaah = 0;
      end
      1: begin // walking right
        walk_left = 0;
        walk_right = 1;
        digging = 0;
        aaah = 0;
      end
      2: begin // falling
        walk_left = 0;
        walk_right = 0;
        digging = 0;
        aaah = 1;
      end
      3: begin // digging
        walk_left = 0;
        walk_right = 0;
        digging = 1;
        aaah = 0;
      end
    endcase
  end
endmodule
