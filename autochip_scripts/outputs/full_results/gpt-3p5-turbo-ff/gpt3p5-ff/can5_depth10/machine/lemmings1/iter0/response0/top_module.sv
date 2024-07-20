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
  
  reg state;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WL;
    end else begin
      if (state == WL && bump_left) begin
        state <= WR;
      end else if (state == WR && bump_right) begin
        state <= WL;
      end else begin
        state <= state;
      end
    end
  end
  
  always @(state) begin
    if (state == WL) begin
      walk_left <= 1'b1;
      walk_right <= 1'b0;
    end else begin
      walk_left <= 1'b0;
      walk_right <= 1'b1;
    end
  end
  
endmodule
