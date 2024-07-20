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
      state <= 2'b10; // Initial state: walking left
    end else begin
      case (state)
        2'b00: begin // State: switched
          if (bump_left && bump_right) begin
            state <= 2'b01; // Switch to walking right
          end else if (bump_left) begin
            state <= 2'b10; // Switch to walking left
          end else if (bump_right) begin
            state <= 2'b01; // Switch to walking right
          end
        end
        2'b01: begin // State: walking right
          if (bump_left && bump_right) begin
            state <= 2'b01; // Remain in walking right state
          end else if (bump_left) begin
            state <= 2'b10; // Switch to walking left
          end else if (bump_right) begin
            state <= 2'b01; // Remain in walking right state
          end
        end
        2'b10: begin // State: walking left
          if (bump_left && bump_right) begin
            state <= 2'b01; // Switch to walking right
          end else if (bump_left) begin
            state <= 2'b10; // Remain in walking left state
          end else if (bump_right) begin
            state <= 2'b01; // Switch to walking right
          end
        end
      endcase
    end
  end
  
  assign walk_left = (state == 2'b10) ? 1'b1 : 1'b0;
  assign walk_right = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
