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

always @(a or b or state_reg) begin
  case(state_reg)
    2'b00: state_next = a & b;
    2'b01: state_next = 1'b0;
    2'b10: state_next = 1'b0;
    2'b11: state_next = a | b;
  endcase
end

always @(posedge clk) begin
  if(state_reg == 2'b11)
    q <= 1'b1;
  else
    q <= 1'b0;
end

assign state = state_reg;

endmodule
