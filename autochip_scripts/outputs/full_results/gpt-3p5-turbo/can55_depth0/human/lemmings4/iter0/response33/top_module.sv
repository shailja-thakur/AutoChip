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

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
      state <= 0;
    end else begin
      case (state)
        0: begin // walking left
          if (bump_right) begin
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
            state <= 1;
          end else if (!ground) begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
            state <= 2;
          end else if (dig) begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
            state <= 3;
          end
        end
        1: begin // walking right
          if (bump_left) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            state <= 0;
          end else if (!ground) begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
            state <= 2;
          end else if (dig) begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
            state <= 3;
          end
        end
        2: begin // falling
          if (ground) begin
            walk_left <= (state == 0);
            walk_right <= (state == 1);
            aaah <= 0;
            digging <= 0;
            state <= (state == 0) ? 0 : 1;
          end
        end
        3: begin // digging
          if (!ground) begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
            state <= 2;
          end
        end
      endcase
    end
  end

endmodule
