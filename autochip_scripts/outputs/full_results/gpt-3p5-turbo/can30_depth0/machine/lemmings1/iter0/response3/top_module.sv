module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

  parameter WL = 1'b0;
  parameter WR = 1'b1;
  
  reg state, next_state;
  
  always @(posedge clk) begin
    if (areset) begin
      state <= WL;
    end else begin
      state <= next_state;
    end
  end
  
  always @(state, bump_left, bump_right) begin
    case (state)
      WL: begin
        if (bump_left) begin
          next_state = WR;
        end else begin
          next_state = WL;
        end
      end
      WR: begin
        if (bump_right) begin
          next_state = WL;
        end else begin
          next_state = WR;
        end
      end
    endcase
  end
  
  always @(state) begin
    case (state)
      WL: begin
        walk_left = 1'b1;
        walk_right = 1'b0;
      end
      WR: begin
        walk_left = 1'b0;
        walk_right = 1'b1;
      end
    endcase
  end

endmodule
