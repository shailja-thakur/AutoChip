module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

  reg [1:0] state;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b01; // Walking left state
    end
    else begin
      case (state)
        2'b00: // Initial state
          begin
            if (bump_left && !bump_right)
              state <= 2'b01; // Switch to walking left
            else if (!bump_left && bump_right)
              state <= 2'b10; // Switch to walking right
            else if (bump_left && bump_right)
              state <= 2'b10; // Switch to walking right
          end
        2'b01: // Walking left state
          begin
            if (!bump_left && bump_right)
              state <= 2'b10; // Switch to walking right
          end
        2'b10: // Walking right state
          begin
            if (bump_left && !bump_right)
              state <= 2'b01; // Switch to walking left
          end
        default: // Unexpected state
          state <= 2'b01; // Reset to walking left
      endcase
    end
  end
  
  always @(state) begin
    case (state)
      2'b01: // Walking left state
        begin
          walk_left = 1'b1;
          walk_right = 1'b0;
        end
      2'b10: // Walking right state
        begin
          walk_left = 1'b0;
          walk_right = 1'b1;
        end
      default: // Unexpected state
        begin
          walk_left = 1'b1;
          walk_right = 1'b0;
        end
    endcase
  end
  
endmodule
