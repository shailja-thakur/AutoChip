module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

reg q_reg;
reg state_reg;
reg state_next;

always @(posedge clk) begin
  state_reg <= state_next;
  q_reg <= state_reg;
end

always @(a or b) begin
  case ({a, b})
    2'b00: state_next = state_reg;
    2'b01: state_next = 1'b0;
    2'b10: state_next = 1'b1;
    2'b11: state_next = 1'b1;
  endcase
end

assign state = state_reg;
assign q = q_reg;

endmodule
