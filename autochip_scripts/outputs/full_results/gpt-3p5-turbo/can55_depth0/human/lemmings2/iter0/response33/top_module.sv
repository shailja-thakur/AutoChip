module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output reg walk_left,
  output reg walk_right,
  output reg aaah
);

  reg [1:0] state;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin // Walking left
          if (bump_right && !bump_left)
            state <= 2'b01;
          else if (bump_right && bump_left)
            state <= 2'b10;
          else if (!ground)
            state <= 2'b11;
        end
        2'b01: begin // Walking right
          if (bump_left && !bump_right)
            state <= 2'b00;
          else if (bump_left && bump_right)
            state <= 2'b10;
          else if (!ground)
            state <= 2'b11;
        end
        2'b10: begin // Bumped on both sides
          if (!ground)
            state <= 2'b11;
          else if (walk_left)
            state <= 2'b00;
          else if (walk_right)
            state <= 2'b01;
        end
        2'b11: begin // Falling
          if (ground)
            state <= walk_left ? 2'b00 : 2'b01;
        end
      endcase
    end
  end

  always @(*) begin
    case (state)
      2'b00: begin // Walking left
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
      end
      2'b01: begin // Walking right
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
      end
      2'b10: begin // Bumped on both sides
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
      end
      2'b11: begin // Falling
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
      end
    endcase
  end

endmodule
