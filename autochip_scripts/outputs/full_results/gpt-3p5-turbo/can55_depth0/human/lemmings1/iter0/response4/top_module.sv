module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

   reg [1:0] state;
   
   always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b01; // Initialize state to walking left
    else begin
      case(state)
        // Walking left state transitions
        2'b01: begin
          if (bump_right && !bump_left)
            state <= 2'b10; // Switch to walking right if bumped on the right
        end
        // Walking right state transitions
        2'b10: begin
          if (bump_left && !bump_right)
            state <= 2'b01; // Switch to walking left if bumped on the left
        end
      endcase
    end
  end
   
   always @(state) begin
    case(state)
      // Walking left state behavior
      2'b01: begin
        walk_left = 1;
        walk_right = 0;
      end
      // Walking right state behavior
      2'b10: begin
        walk_left = 0;
        walk_right = 1;
      end
      default: begin
        walk_left = 0;
        walk_right = 0;
      end
    endcase
  end

endmodule
