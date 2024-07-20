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
end

always @(posedge clk) begin
  q_reg <= state_reg;
  state_reg <= state_next;
end

always @(a or b or state_reg) begin
  case(state_reg)
    1'b0: begin
      if(a & b)
        state_next = 1'b1;
      else
        state_next = 1'b0;
    end
    1'b1: begin
      state_next = 1'b0;
    end
  endcase
end

always @(posedge clk) begin
  if(state_reg == 1'b0)
    q = a | b;
  else
    q = 1'b1;
  state = state_reg;
end

endmodule
