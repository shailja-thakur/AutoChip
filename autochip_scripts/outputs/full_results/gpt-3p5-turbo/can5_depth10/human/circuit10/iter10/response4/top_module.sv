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
  if(a & b)
    state_next = 1'b1;
  else
    state_next = 1'b0;
end

initial begin
  q = 1'b0;
  state = 1'b0;
end

always @(posedge clk) begin
  case(state_reg)
    1'b0: begin
      q = a | b;
      state = 1'b0;
    end
    1'b1: begin
      q = 1'b1;
      state = 1'b1;
    end
  endcase
end

endmodule
