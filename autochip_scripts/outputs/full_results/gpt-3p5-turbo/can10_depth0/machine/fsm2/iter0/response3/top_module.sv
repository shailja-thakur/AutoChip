module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

  reg [1:0] state, next_state;

  always_comb begin
    case(state)
      2'b00: next_state = (j) ? 2'b01 : 2'b00;
      2'b01: next_state = (k) ? 2'b00 : 2'b01;
      default: next_state = 2'b00;
    endcase
  end

  always_ff @(posedge clk) begin
    if (areset)
      state <= 2'b00;
    else
      state <= next_state;
  end

  assign out = (state == 2'b01) ? 1 : 0;

endmodule
