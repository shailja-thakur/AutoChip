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
    if (areset) begin
      state <= 2'b01; // Initial state is walking left
    end else begin
      case (state)
        2'b01: begin // Walking left state
          if (bump_right) begin
            state <= 2'b10; // Switch to walking right state
          end
        end
        2'b10: begin // Walking right state
          if (bump_left) begin
            state <= 2'b01; // Switch to walking left state
          end
        end
      endcase
    end
  end
  
  assign walk_left = (state == 2'b01);
  assign walk_right = (state == 2'b10);
  
endmodule
