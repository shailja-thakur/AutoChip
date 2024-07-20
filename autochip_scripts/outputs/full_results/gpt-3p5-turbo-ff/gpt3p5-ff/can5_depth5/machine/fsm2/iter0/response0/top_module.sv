module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

reg [1:0] state, next_state;

always @(*) begin
  case (state)
    2'b00: next_state = (j == 1'b1) ? 2'b01 : 2'b00;
    2'b01: next_state = (k == 1'b1) ? 2'b00 : 2'b01;
  endcase
end

always @(posedge clk) begin
  if (areset == 1'b1)
    state <= 2'b00;
  else
    state <= next_state;
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
