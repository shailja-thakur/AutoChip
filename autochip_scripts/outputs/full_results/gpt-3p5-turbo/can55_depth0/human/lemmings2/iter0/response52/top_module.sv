module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
);

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= 2'b1;
  end else begin
    case(state)
      2'b00: begin // Walking Left
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        if (bump_right) begin
          state <= 2'b10; // Switch Direction
        end else if (!ground) begin
          state <= 2'b11; // Falling
        end
      end
      2'b01: begin // Walking Right
        walk_left <= 0;
        walk_right <= 1;
        aaah <= 0;
        if (bump_left) begin
          state <= 2'b10; // Switch Direction
        end else if (!ground) begin
          state <= 2'b11; // Falling
        end
      end
      2'b10: begin // Switch Direction
        walk_left <= ~walk_left;
        walk_right <= ~walk_right;
        aaah <= 0;
        if (!ground) begin
          state <= 2'b11; // Falling
        end else begin
          if (walk_left) begin
            state <= 2'b00; // Walking Left
          end else begin
            state <= 2'b01; // Walking Right
          end
        end
      end
      2'b11: begin // Falling
        walk_left <= 0;
        walk_right <= 0;
        aaah <= 1;
        if (ground) begin
          if (walk_left) begin
            state <= 2'b00; // Walking Left
          end else begin
            state <= 2'b01; // Walking Right
          end
        end
      end
    endcase
  end
end

endmodule
