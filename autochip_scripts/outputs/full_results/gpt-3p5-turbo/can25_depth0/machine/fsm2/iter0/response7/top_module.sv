module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

  reg state, next_state;

  always @* begin
    if (state == 0) begin  // state A
      if (j) begin
        next_state = 1;  // state B
      end else begin
        next_state = 0;  // stay in state A
      end
    end else begin  // state B
      if (k) begin
        next_state = 0;  // state A
      end else begin
        next_state = 1;  // stay in state B
      end
    end
  end

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 0;  // reset to state A
    end else begin
      state <= next_state;  // update state based on next_state value
    end
  end

  assign out = (state == 1);

endmodule
