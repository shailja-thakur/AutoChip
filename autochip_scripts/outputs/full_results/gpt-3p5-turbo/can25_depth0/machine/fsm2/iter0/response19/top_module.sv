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
    2'b00: next_state = j ? 2'b01 : 2'b00;
    2'b01: next_state = k ? 2'b00 : 2'b01;
    default: next_state = 2'b00;
  endcase
end

always_ff @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= 2'b00;
  end else begin
    state <= next_state;
  end
end

always_comb begin
  out = (state == 2'b01) ? 1'b1 : 1'b0;
end

endmodule
