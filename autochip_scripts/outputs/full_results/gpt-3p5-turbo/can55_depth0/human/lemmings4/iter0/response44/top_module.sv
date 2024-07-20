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

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 5'b01000; // initial state is walking left
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
    end else begin
      state <= next_state;
      case(state)
        5'b00001: begin // falling state
          aaah <= 1;
          walk_left <= 0;
          walk_right <= 0;
          digging <= 0;
          if (ground) begin
            next_state <= 5'b01000; // back to walking after hitting the ground
          else if (state == 20) begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            next_state <= 5'b01111; // splatter state
          end
          else begin
            next_state <= state + 1;
          end
        end
        5'b01000: begin // walking left state
          walk_left <= 1;
          walk_right <= 0;
          aaah <= 0; // not falling
          digging <= 0;
          if (bump_right) begin
            next_state <= 5'b00100; // switch to walking right if bumped on the right
          else if (bump_left) begin
            next_state <= 5'b00010; // switch to walking left if bumped on the left
          else if (dig && ground) begin
            next_state <= 5'b00101; // start digging if dig=1 and on ground
          else begin
            next_state <= state;
          end
        end
        5'b00010: begin // walking left bumped on the left state
          walk_left <= 1;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
          if (bump_right) begin
            next_state <= 5'b00011; // switch to walking right if bumped on the right
          else if (dig && ground) begin
            next_state <= 5'b00101; // start digging if dig=1 and on ground
          else begin
            next_state <= state;
          end
        end
        5'b00011: begin // walking right bumped on both sides state
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
          if (dig && ground) begin
            next_state <= 5'b00101; // start digging if dig=1 and on ground
          else begin
            next_state <= state;
          end
        end
        5'b00100: begin // walking right bumped on the right state
          walk_left <= 0;
          walk_right <= 1;
          aaah <= 0;
          digging <= 0;
          if (bump_left) begin
            next_state <= 5'b00011; // switch to walking left if bumped on the left
          else if (dig && ground) begin
            next_state <= 5'b00101; // start digging if dig=1 and on ground
          else begin
            next_state <= state;
          end
        end
        5'b00101: begin // digging state
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 0;
          digging <= 1;
          if (!ground) begin
            next_state <= 5'b00101; // continue digging if no ground
          else begin
            next_state <= 5'b00001; // fall if ground reappears
          end
        end
        5'b01111: begin // splatter state
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
          next_state <= 5'b01111;
        end
      endcase
    end
  end

endmodule
