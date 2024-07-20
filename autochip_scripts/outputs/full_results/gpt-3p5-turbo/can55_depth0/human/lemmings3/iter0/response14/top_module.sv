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
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b10; // walking left
    end else begin
      case (state)
        2'b00: begin // walking right
          if (bump_left) begin
            state <= 2'b01; // switch directions
          end else if (bump_right) begin
            state <= 2'b10; // continue walking right
          end else if (!ground) begin
            state <= 2'b11; // falling
          else if (dig && ground) begin
            state <= 2'b00; // start digging
          end
        end
        2'b01: begin // walking left
          if (bump_left) begin
            state <= 2'b01; // continue walking left
          end else if (bump_right) begin
            state <= 2'b10; // switch directions
          end else if (!ground) begin
            state <= 2'b11; // falling
          else if (dig && ground) begin
            state <= 2'b00; // start digging
          end
        end
        2'b10: begin // falling
          if (bump_left || bump_right) begin
            state <= 2'b10; // continue falling
          end else if (ground) begin
            state <= state; // continue walking in same direction
          end
        end
        2'b11: begin // digging
          if (!ground) begin
            state <= 2'b11; // continue digging
          end else begin
            if (state == 2'b11 && ground) begin
              state <= state; // continue walking in same direction after falling
            end else if (state != 2'b00 && state != 2'b01 && dig && ground) begin
              state <= 2'b00; // start digging
            end
            // for other cases, stay in the same state
          end
        end
        default: state <= 2'b10; // default state is walking right
      endcase
    end
  end
  
  // Output assignment
  assign walk_left = (state == 2'b01 || state == 2'b11); // walking left or digging
  assign walk_right = (state == 2'b00 || state == 2'b10); // walking right or falling
  assign aaah = (state == 2'b11); // falling
  assign digging = (state == 2'b11); // digging
  
endmodule
