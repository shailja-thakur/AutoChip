module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

  reg [1:0] state;
  reg output;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b01; // walking left
    else begin
      case (state)
        2'b00: begin // walking right
          if (bump_left & bump_right)
            state <= 2'b01; // switch directions
          else if (bump_left)
            state <= 2'b01; // switch to walking left
          else if (bump_right)
            state <= 2'b00; // continue walking right
        end

        2'b01: begin // walking left
          if (bump_left & bump_right)
            state <= 2'b00; // switch directions
          else if (bump_left)
            state <= 2'b01; // continue walking left
          else if (bump_right)
            state <= 2'b00; // switch to walking right
        end
      endcase
    end
  end

  always @(state) begin
    case (state)
      2'b00: begin // walking right
        walk_left <= 1'b0;
        walk_right <= 1'b1;
      end
      2'b01: begin // walking left
        walk_left <= 1'b1;
        walk_right <= 1'b0;
      end
    endcase
  end
  
endmodule
