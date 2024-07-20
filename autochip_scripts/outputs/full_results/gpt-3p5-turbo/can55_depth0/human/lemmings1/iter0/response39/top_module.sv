module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
  
  reg [1:0] state;     // State variable to store current state
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b10;   // Initialize state to 'walk_left' when areset is high
    end else begin
      case(state)
        2'b00: begin    // Current state is 'walk_left'
          if (bump_left && bump_right) begin
            state <= 2'b01;   // If bumped on both sides, switch to 'walk_right'
          end else if (bump_left) begin
            state <= 2'b01;   // If bumped on left side, switch to 'walk_right'
          end
        end
        2'b01: begin    // Current state is 'walk_right'
          if (bump_left && bump_right) begin
            state <= 2'b00;   // If bumped on both sides, switch to 'walk_left'
          end else if (bump_right) begin
            state <= 2'b00;   // If bumped on right side, switch to 'walk_left'
          end
        end
      endcase
    end
  end

  // Output assignments based on current state
  assign walk_left = (state == 2'b00);
  assign walk_right = (state == 2'b01);
  
endmodule
