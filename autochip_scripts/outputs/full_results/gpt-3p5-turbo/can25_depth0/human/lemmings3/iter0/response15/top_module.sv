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
      state <= 2'b01; // initialize state to walk left
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
    end else begin
      case(state)
        2'b01: begin // Walking left state
          if (bump_right && !bump_left && ground) begin // Switch direction to walk right
            state <= 2'b10;
            walk_left <= 0;
            walk_right <= 1;
          end else if (dig && ground) begin // Start digging if on ground
            state <= 2'b11;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
          end else begin
            // Stay in current state
            state <= 2'b01;
          end
        end
        2'b10: begin // Walking right state
          if (bump_left && !bump_right && ground) begin // Switch direction to walk left
            state <= 2'b01;
            walk_left <= 1;
            walk_right <= 0;
          end else if (dig && ground) begin // Start digging if on ground
            state <= 2'b11;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
          end else begin
            // Stay in current state
            state <= 2'b10;
          end
        end
        2'b11: begin // Digging state
          if (!ground && !dig) begin // The ground disappears, start falling
            state <= 2'b00;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
          end else begin
            // Stay in current state
            state <= 2'b11;
          end
        end
        2'b00: begin // Falling state
          if (ground) begin // The ground reappears, resume walking
            state <= walk_left ? 2'b01 : 2'b10;
            walk_left <= walk_left ? 1 : 0;
            walk_right <= walk_right ? 1 : 0;
            aaah <= 0;
            digging <= 0;
          end else begin
            // Stay in current state
            state <= 2'b00;
          end
        end
      endcase
    end
  end
endmodule
