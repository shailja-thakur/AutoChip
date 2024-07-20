module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

  reg [1:0] state;
  reg walk_left;
  reg walk_right;
  reg aaah;
  reg digging;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b10; // walking left
      walk_left <= 1'b1;
      walk_right <= 1'b0;
      aaah <= 1'b0;
      digging <= 1'b0;
    end else begin
      case(state)
        2'b00: begin // falling
          if (ground) begin
            state <= 2'b10; // walking left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
          end else if (dig) begin
            state <= 2'b11; // digging
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
          end else if (bump_left || bump_right) begin
            state <= 2'b01; // switching direction
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
          end else begin
            state <= 2'b00; // continue falling
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b1;
            digging <= 1'b0;
          end
        end
        2'b01: begin // switching direction
          state <= 2'b10; // walking left
          walk_left <= 1'b1;
          walk_right <= 1'b0;
          aaah <= 1'b0;
          digging <= 1'b0;
        end
        2'b10: begin // walking left
          if (dig && ground) begin
            state <= 2'b11; // digging
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
          end else if (dig) begin
            state <= 2'b10; // continue walking left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
          end else if (bump_right) begin
            state <= 2'b01; // switching direction
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
          end else if (bump_left) begin
            state <= 2'b10; // continue walking left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
          end else begin
            state <= 2'b10; // continue walking left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
          end
        end
        2'b11: begin // digging
          if (ground) begin
            state <= 2'b10; // walking left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
          end else begin
            state <= 2'b11; // continue digging
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
          end
        end
      endcase
    end
  end

endmodule
