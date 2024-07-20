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

  // Define the possible states of the finite state machine
  parameter ST_WALK_LEFT = 2'b00;
  parameter ST_WALK_RIGHT = 2'b01;
  parameter ST_FALL = 2'b10;

  // Define the flip-flops to store the current state and next state
  reg[1:0] state;
  reg[1:0] next_state;

  // Define the output registers
  reg out_walk_left;
  reg out_walk_right;
  reg out_aaah;

always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= ST_WALK_LEFT;
    end else begin
      state <= next_state;
    end
  end

  always @* begin
    case (state)
      ST_WALK_LEFT: begin
        if (bump_left) begin
          next_state = ST_WALK_RIGHT;
        end else if (bump_right) begin
          next_state = ST_WALK_RIGHT;
        end else begin
          next_state = ST_WALK_LEFT;
        end
        out_walk_left = 1;
        out_walk_right = 0;
        out_aaah = 0;
      end
      ST_WALK_RIGHT: begin
        if (bump_right) begin
          next_state = ST_WALK_LEFT;
        end else if (bump_left) begin
          next_state = ST_WALK_LEFT;
        end else begin
          next_state = ST_WALK_RIGHT;
        end
        out_walk_left = 0;
        out_walk_right = 1;
        out_aaah = 0;
      end
      ST_FALL: begin
        if (ground) begin
          if (state == ST_WALK_LEFT) begin
            next_state = ST_WALK_LEFT;
          end else if (state == ST_WALK_RIGHT) begin
            next_state = ST_WALK_RIGHT;
          else begin
            next_state = ST_FALL;
          end
        end
        out_walk_left = 0;
        out_walk_right = 0;
        out_aaah = 1;
    endcase
  end
endmodule
